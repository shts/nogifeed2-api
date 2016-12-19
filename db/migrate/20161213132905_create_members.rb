class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name_main
      t.string :name_sub
      t.string :blog_url
      t.string :rss_url
      t.string :status
      t.string :image_url
      t.string :birthday
      t.string :blood_type
      t.string :constellation
      t.string :height
      t.integer :favorite
      t.string :key

      t.timestamps null: false
    end
  end
end
