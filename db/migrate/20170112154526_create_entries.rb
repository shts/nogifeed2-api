class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :url
      t.string :member_id
      t.string :original_raw_image_urls
      t.string :original_thumbnail_urls
      t.string :uploaded_raw_image_urls
      t.string :uploaded_thumbnail_urls

      t.timestamps null: false
    end
  end
end
