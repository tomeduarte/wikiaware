require File.expand_path(File.join(File.dirname(__FILE__), '../test_helper'))

class SubscriptionsControllerTest < ActionController::TestCase
fixtures :users, :subscriptions, :wikis, :wiki_pages, :projects

  def setup
    @admin = User.find(1)
    @controller = SubscriptionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:user_id] = @admin.id
    Setting.default_language = 'en'
    User.current = @admin
  end

  context "routes" do
    should_route  :get, '/subscriptions', :controller => 'subscriptions', :action => 'index'
    should_route  :post, '/subscriptions', :controller => 'subscriptions', :action => 'create'
    should_route  :delete, '/subscriptions/1', :controller => 'subscriptions', :action => 'destroy', :id => 1
  end

  context "get :index" do
    setup do
      get :index
    end

    should_assign_to :subscriptions

    should_respond_with :success
    should_render_template :index
  end

  context "post :create" do
    setup do
      post :create, :page_id => 1
    end

    should_respond_with :redirect
    should_redirect_to("index") { subscriptions_url }

    should "create a record" do
      assert Subscription.find(:all, :conditions => [ "user_id = ? AND page_id = ?", @admin.id, 1])
    end
  end

  context "delete :destroy" do
    setup do
      @subscription = Subscription.find(1)
      delete :destroy, :id => @subscription.id
    end

    should_respond_with :redirect
    should_redirect_to("index") { subscriptions_url }

    should "delete the record" do
      assert_nil Subscription.find(:first, :conditions => ["user_id = ? AND page_id = ?", @subscription.user_id, @subscription.page_id])
    end
  end
end

