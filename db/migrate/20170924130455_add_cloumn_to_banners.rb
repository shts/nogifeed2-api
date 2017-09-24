class AddCloumnToBanners < ActiveRecord::Migration
  def self.up
    create_table :banners do |t|
      t.string :title
      t.string :thumurl
      t.string :bnrurl
      t.string :linkurl
      t.timestamps
    end
  end
  def self.down
    drop_table :banners
  end
end
