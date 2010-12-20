require File.dirname(__FILE__) + '/../test_helper'

class FriendshipsControllerTest < ActionController::TestCase
fixtures :users, :friendships

  def setup
    @admin = User.find(1)
    @controller = FriendshipsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:user_id] = @admin.id
    Setting.default_language = 'en'
    User.current = @admin
  end

  context "routes" do
    should_route  :post, '/friendships', :controller => 'friendships', :action => 'create'
    should_route  :delete, '/friendships/1', :controller => 'friendships', :action => 'destroy', :id => 1
    should_route  :get, '/friendships/1/block', :controller => 'friendships', :action => 'block', :id => 1
    should_route  :get, '/friendships/1/accept', :controller => 'friendships', :action => 'accept', :id => 1
    should_route  :get, '/friendships/1/reject', :controller => 'friendships', :action => 'reject', :id => 1
  end

  context "post :create" do
    context "with friend_id = user_id" do
      setup do
        post :create, :friend_id => @admin.id
      end

      should_respond_with :redirect
      should_redirect_to("index") { posts_url }

      should "not create a record" do
        assert_equal [], Friendship.find(:all, :conditions => [ "user_id = ? AND friend_id = ?", @admin.id, @admin.id])
      end
    end

    context "with valid data" do
      setup do
        post :create, :friend_id => '2'
      end

      should_respond_with :redirect
      should_redirect_to("index") { posts_url }

      should "create a record" do
        assert Friendship.find(:all, :conditions => [ "user_id = ? AND friend_id = ?", @admin.id, :friend_id])
      end
    end
  end

  context "delete :destroy" do
    setup do
      @friendship = Friendship.find(1)
      delete :destroy, :id => @friendship.id
    end

    should_respond_with :redirect
    should_redirect_to("index") { posts_url }

    should "delete the record" do
      assert_nil Friendship.find(:first, :conditions => ["user_id = ? AND friend_id = ?", @friendship.user_id, @friendship.friend_id])
    end
  end

  context "get :accept" do
    setup do
      @friendship = Friendship.find(3)
      get :accept, :id => @friendship.id
    end

    should_respond_with :redirect
    should_redirect_to("index") { posts_url }

    should "update the record" do
      assert_equal true, Friendship.find(3).accepted
    end
  end

  context "get :reject" do
    setup do
      @friendship = Friendship.find(3)
      get :reject, :id => @friendship.id
    end

    should_respond_with :redirect
    should_redirect_to("index") { posts_url }

    should "delete the record" do
      assert_nil Friendship.find(:first, :conditions => ["user_id = ? AND friend_id = ?", @friendship.user_id, @friendship.friend_id])
    end
  end

  context "get :block" do
    setup do
      @friendship = Friendship.find(3)
      get :block, :id => @friendship.id
    end

    should_respond_with :redirect
    should_redirect_to("index") { posts_url }

    should "update the record" do
      assert_equal true, Friendship.find(3).blocked
    end
  end
end

