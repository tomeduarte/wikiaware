require File.dirname(__FILE__) + '/../test_helper'

class FriendshipTest < ActiveSupport::TestCase
  fixtures :friendships, :users

  def setup
    User.current = nil
    @admin = User.find(1)
    @jdoe = User.find(2)
  end

  def test_create
    friendship = Friendship.new

    # can't save new/empty object
    assert !friendship.save
    assert_equal friendship.errors.count, 3

    # can't save without friend
    friendship.user = @admin
    assert !friendship.save
    assert_equal friendship.errors.count, 1

    # saves full friendship
    friendship.friend = @jdoe
    assert friendship.save 
  end 

  def test_cant_befriend_yourself
    friendship = Friendship.new

    friendship.user = @admin
    friendship.friend = @admin
    assert !friendship.save
    assert_equal friendship.errors.count, 1
  end
end
