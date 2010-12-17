require File.dirname(__FILE__) + '/../test_helper'

class FriendshipsControllerTest < ActionController::TestCase

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
    should_route  :get, '/friendships/1/block', :controller => 'friendships', :action => 'block_friendship', :id => 1
    should_route  :get, '/friendships/1/accept', :controller => 'friendships', :action => 'accept_friendship', :id => 1
    should_route  :get, '/friendships/1/reject', :controller => 'friendships', :action => 'reject_friendship', :id => 1
  end

  context "post :create" do
    setup do
      post :create, :friendship => {:friend_id => '2'}
    end

    should_respond_with :redirect
    should_redirect_to("index") {{:controller => 'posts', :action => 'index'}}
  end

  context "delete :destroy" do
      setup do
        @friendship = Friendship.find(1)
        delete :destroy, :id => @friendship.id
      end

      should_respond_with :redirect
      should_redirect_to("index") {{:controller => 'posts', :action => 'index'}}
  end

end

