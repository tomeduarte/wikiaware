require File.expand_path(File.join(File.dirname(__FILE__), '../test_helper'))

class NotificationsControllerTest < ActionController::TestCase
fixtures :users, :notifications, :subscriptions, :wikis, :wiki_pages, :projects

  def setup
    @controller = NotificationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "routes" do
    should_route  :get, '/notifications', :controller => 'notifications', :action => 'index'
    should_route  :put, '/notifications/1', :controller => 'notifications', :action => 'update', :id => 1
  end

  context "get :index" do
    setup do
      get :index
    end

    should_assign_to :notifications_unread
    should_assign_to :notifications_read

    should_respond_with :success
    should_render_template :index
  end

  context "put :update" do
    setup do
      @notification = Notification.find(1)
      put :update, :id => @notification.id, :notification => {:read => true}
    end

    should_respond_with :redirect
    should_redirect_to("index") {{:action => 'index'}}

    should "update the record" do
      assert_equal true, Notification.find(1).read
    end
  end
end

