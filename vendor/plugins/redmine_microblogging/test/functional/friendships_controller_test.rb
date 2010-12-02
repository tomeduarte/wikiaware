require File.dirname(__FILE__) + '/../test_helper'

class FriendshipsControllerTest < ActionController::TestCase

  def setup
    User.current = nil
    @admin = User.find(1)
    @jdoe = User.find(2)
    @jsmith = User.find(3)
    @admin_post = Post.find(1)
    @jdoe_post = Post.find(2)
    @jsmith_post = Post.find(3)
  end

  context "FOLLOW user" do

  end

  def test_follow
    
  end

  def test_unfollow
  end

  def test_accept
  end

  def test_reject
  end

  def test_block
  end

  def test_unblock
    assert_equal "is_implemented", "true"
  end
end
