require File.expand_path(File.join(File.dirname(__FILE__), '../test_helper'))

class PostsControllerTest < ActionController::TestCase
fixtures :users, :posts

  def setup
    @admin = User.find(1)
    @controller = PostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:user_id] = @admin.id
    Setting.default_language = 'en'
    User.current = @admin
  end

  context "routes" do
    should_route  :get, '/posts', :controller => 'posts', :action => 'index'
    should_route  :get, '/posts/new', :controller => 'posts', :action => 'new'
    should_route  :post, '/posts', :controller => 'posts', :action => 'create'
    should_route  :delete, '/posts/1', :controller => 'posts', :action => 'destroy', :id => 1
  end

  context "get :index" do
    setup do
      get :index
    end

    should_assign_to :user
    should_assign_to :timeline

    should_respond_with :success
    should_render_template :index
  end

  context "get :index with search" do
    setup do
      get :index, :search => 'admin'
    end

    should_assign_to :user
    should_assign_to :timeline
    should_assign_to :search_results

    should_respond_with :success
    should_render_template :index
  end

  context "get :new" do
    setup do
      get :new
    end

    should_assign_to :post
    should_respond_with :success
    should_render_template :new

    should "initialize a new Post" do
      assert_equal Post, assigns(:post).class
      assert assigns(:post).new_record?
    end
  end

  context "post :create" do
    setup do
      post :create, :post => {:content => 'Test'}
    end

    should_respond_with :redirect
    should_redirect_to("index") {{:action => 'index'}}
  end

  context "delete :destroy" do
      setup do
        @post = Post.find(1)
        delete :destroy, :id => @post.id
      end

      should_respond_with :redirect
      should_redirect_to("index") {{:action => 'index'}}
  end

end

