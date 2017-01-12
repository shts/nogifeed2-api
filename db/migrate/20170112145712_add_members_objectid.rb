class AddMembersObjectid < ActiveRecord::Migration
  def self.up
      add_column(:members, :objectId, :text)
  end

  def self.down
      ramove_column(:members, :objectId)
  end
end
