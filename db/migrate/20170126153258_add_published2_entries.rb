class AddPublished2Entries < ActiveRecord::Migration
  def self.up
      add_column(:entries, :published2, :datetime)
  end

  def self.down
      ramove_column(:entries, :published2)
  end
end
