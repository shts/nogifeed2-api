class AddEntriesPublished < ActiveRecord::Migration
  def self.up
      add_column(:entries, :published, :text)
  end

  def self.down
      ramove_column(:entries, :published)
  end
end
