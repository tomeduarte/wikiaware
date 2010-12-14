require File.dirname(__FILE__) + '/../test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  fixtures :subscriptions, :users, :wiki_pages

  def setup
    User.current = nil
    @admin = User.find(1)
    @wiki_page = WikiPage.find(3)
    @subscription = Subscription.find(:first, :conditions => ["user_id = ? AND page_id = ?",@admin.id,@wiki_page.id])
  end

  def test_create
    subscription = Subscription.new

    # can't save new/empty object
    assert !subscription.save
    assert_equal subscription.errors.count, 2

    # can't save without user
    subscription.page = @wiki_page
    assert !subscription.save
    assert_equal subscription.errors.count, 1

    # saves complete subscription
    subscription.user = @admin
    assert subscription.save
  end

  def test_destroy
    @subscription.destroy
    assert_nil Subscription.find(:first, :conditions => ["user_id = ? AND page_id = ?",@admin.id,@wiki_page.id])
  end
end
