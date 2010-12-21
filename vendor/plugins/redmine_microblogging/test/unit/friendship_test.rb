require File.dirname(__FILE__) + '/../test_helper'

class FriendshipTest < ActiveSupport::TestCase
  fixtures :friendships, :users

  def setup
    User.current = nil
    @admin = User.find(1)
    @jdoe = User.find(2)
    @friendship_pending = Friendship.find(1)
    @friendship_accepted = Friendship.find(2)
    @friendship_blocked = Friendship.find(4)
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
    assert_equal friendship.accepted, false
    assert_equal friendship.blocked, false
  end

  def test_cant_befriend_yourself
    friendship = Friendship.new

    friendship.user = @admin
    friendship.friend = @admin
    assert !friendship.save
    assert_equal friendship.errors.count, 1
  end

  def test_block
    # check valid state
    assert_equal @friendship_accepted.accepted, true
    assert_equal @friendship_accepted.blocked, false

    # block friendship
    @friendship_accepted.blocked = true
    assert @friendship_accepted.save
    assert_equal @friendship_accepted.accepted, true
    assert_equal @friendship_accepted.blocked, true
  end

  def test_unblock
    # check valid state
    assert_equal @friendship_blocked.accepted, true
    assert_equal @friendship_blocked.blocked, true

    # unblock friendship
    @friendship_blocked.blocked = false
    assert @friendship_blocked.save
    assert_equal @friendship_blocked.accepted, true
    assert_equal @friendship_blocked.blocked, false
  end

  def test_accept
    # check valid state
    assert_equal @friendship_pending.accepted, false

    # accept friendship and save
    @friendship_pending.accepted = true
    assert @friendship_pending.save
  end

  def test_destroy
    friendship = Friendship.find(:first, :conditions => ["user_id = ? AND friend_id = ?",@admin.id, @jdoe.id])
    assert friendship.destroy
    assert_nil Friendship.find(:first, :conditions => ["user_id = ? AND friend_id = ?",@admin.id, @jdoe.id])
  end
end

