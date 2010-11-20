class AddTimestampToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :created_at, :datetime
  end

  def self.down
    remove_column :posts, :created_at
  end
end

