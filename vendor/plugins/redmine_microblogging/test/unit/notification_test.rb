require File.dirname(__FILE__) + '/../test_helper'

class NotificationTest < ActiveSupport::TestCase
  fixtures :notifications, :subscriptions

  def setup
    User.current = nil
    @admin = User.find(1)
    @subscription = Subscription.find(1)
    @notification = Notification.find(1)
  end

  def test_create
    notification = Notification.new

    # can't save new/empty object
    assert !notification.save
    assert_equal notification.errors.count, 2

    # assign description, but still missing the subscription
    notification.description = "a sample notification"
    assert !notification.save
    assert_equal notification.errors.count, 1

    # assign subscription and save
    notification.subscription = @subscription
    assert notification.save

    # must be unread on creation
    assert_equal notification.read, false
  end

  def test_read
    # check pre-conditions
    assert_equal @notification.read, false

    # read notification and save it
    @notification.read = true
    assert @notification.save 
  end

end
