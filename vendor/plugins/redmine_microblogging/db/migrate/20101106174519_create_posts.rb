class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.column :user_id, :integer
      t.column :content, :text
    end
  end

  def self.down
    drop_table :posts
  end
end
