require File.dirname(__FILE__) + '/../test_helper'

class PostTest < ActiveSupport::TestCase
  fixtures :posts, :users

  def setup
    User.current = nil
    @admin = User.find(1)
  end

  def test_create
    post = Post.new

    # can't save new/empty object
    assert !post.save
    assert_equal post.errors.count, 2

    # can't save without user
    post.content = "ola"
    assert !post.save
    assert_equal post.errors.count, 1

    # saves complete post
    post.user = @admin
    assert post.save
  end

  def test_destroy
    post = Post.find(:first, :conditions => ["content = ?","second post"]) 

    assert post.destroy
    assert_nil Post.find(:first, :conditions => ["content = ?","second post"]) 
  end
end
