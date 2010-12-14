class AddDefaultReadValueToNotification < ActiveRecord::Migration
  def self.up
    change_column :notifications, :read, :boolean, :default => false
  end

  def self.down
    change_column_default :notifications, :read, nil
  end
end

