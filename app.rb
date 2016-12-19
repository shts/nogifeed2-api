require 'bundler'
require 'kconv'
Bundler.require

if File.exist?("database.yml")
  #Local
  ActiveRecord::Base.configurations = YAML.load_file('database.yml')
  ActiveRecord::Base.establish_connection(:development)
else
  #Heroku
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end

module Api

  class Application < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end
    #configure do
    #  register Sinatra::ActiveRecordExtension
    #  set :database, {adapter: "sqlite3", database: "db/api.db"}
    #end

    # -----------------------------------------------------
    # Routing
    # -----------------------------------------------------
    # get member
    get '/members' do
      # メンバー生成時にkeyがずれたのでここでorder
      Api::Member.all.order(:key).to_json
    end

    # get member
    get '/members/:id' do
      member = Api::Member.find_by_id(params[:id])
      if member == nil then
        404
      else
        member.to_json
      end
    end

    # get member's entries
    # /member/entries?ids[]=1&ids[]=2&skip=0&limit=30
    get '/member/entries' do
      #文字コード指定してやらないと日本語が化ける
    	content_type :json, :charset => 'utf-8'

      @entries = Api::Entry.where(member_id: params[:ids])
                .offset(params[:skip].present? ? params[:skip] : 0)
                .limit(params[:limit].present? ? params[:limit] : 30)
                .order(published: :desc)
      jbuilder :entries
    end

    # get all entries
    # /entries?skip=0&limit=30
    get '/entries' do
    	content_type :json, :charset => 'utf-8'

      @entries = Api::Entry.offset(params[:skip].present? ? params[:skip] : 0)
                .limit(params[:limit].present? ? params[:limit] : 30)
                .order(published: :desc)
      jbuilder :entries
    end

    # get all reports
    # /reports?limit=0&skip=30
    get '/reports' do
      content_type :json, :charset => 'utf-8'

      reports = Api::Report.offset(params[:skip].present? ? params[:skip] : 0)
                .limit(params[:limit].present? ? params[:limit] : 30)
                .order(published: :desc)
      reports.to_json
    end

    # Favorite
    # action 1 -> incriment
    # action -1 -> decriment
    # curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"member_id":"1","action":"incriment"}' http://localhost:9292/favorite -w "\n%{http_code}\n"
    post '/favorite', provides: :json do
      params = JSON.parse request.body.read
      # "Post Favorite #{params} id -> #{params['member_id']} present -> #{params['member_id'].present?}, action -> #{params['action']} present -> #{params['action'].present?}"
      if !params['member_id'].present? || !params['action'].present? then
        return status 500
      end
      if params['action'] != 'incriment' && params['action'] != 'decriment' then
        return status 500
      end

      member = Api::Member.find_by_id(params['member_id'])
      return status 500 if member == nil

      member.favinc if params['action'] == 'incriment'
      member.favdec if params['action'] == 'decriment'

      member.save
    end

    # /matomes?limit=0&skip=30
    get '/matomes' do
      content_type :json, :charset => 'utf-8'

      reports = Api::Matome.offset(params[:skip].present? ? params[:skip] : 0)
                .limit(params[:limit].present? ? params[:limit] : 30)
                .order(entry_published: :desc)
      reports.to_json
    end

    # FCM registeration id
    # curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"reg_id":"1"}' http://localhost:9292/registeration -w "\n%{http_code}\n"
    post '/registration', provides: :json do
      params = JSON.parse request.body.read

      if !params['reg_id'].present? then
        return status 500
      end

      fcm = Api::Fcm.where(reg_id: params['reg_id']).first
      if fcm != nil then
        status 555
        body "{\"request\":\"registration\", \"error\":\"already registration\"}"
        return
      end

      f = Fcm.new()
      f.reg_id = params['reg_id']
      f.save
    end

    # FCM unregisteration id
    # curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"reg_id":"1"}' http://localhost:9292/unregisteration -w "\n%{http_code}\n"
    post '/unregistration', provides: :json do
      params = JSON.parse request.body.read

      if !params['reg_id'].present? then
        return status 500
      end

      fcm = Api::Fcm.where(reg_id: params['reg_id']).first
      if fcm == nil then
        status 555
        body "{\"request\":\"unregistration\", \"error\":\"already unregistration\"}"
        return
      end

      fcm.destroy
    end

  end

  # DBの設定
  class Member < ActiveRecord::Base
    has_many :entries

    before_save :prepare_save

    def prepare_save
      self.favorite = 0 if self.favorite == nil || self.favorite < 0
      self
    end

    def favinc
      self.favorite = self.favorite + 1
    end

    def favdec
      self.favorite = self.favorite - 1
    end

  end

  class Entry < ActiveRecord::Base
    belongs_to :member
  end

  class Matome < ActiveRecord::Base
  end

  class Fcm < ActiveRecord::Base
  end

end
