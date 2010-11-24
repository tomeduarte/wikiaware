class AddFieldsToFriendship < ActiveRecord::Migration
  def self.up
    change_column :friendships, :accepted, :boolean, :default => false
    add_column :friendships, :blocked, :boolean, :default => false
  end

  def self.down
    change_column_default :friendships, :accepted, nil
    drop_column :friendships, :blocked
  end
end

