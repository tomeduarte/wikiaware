class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :subscription_id
      t.boolean :read

      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
