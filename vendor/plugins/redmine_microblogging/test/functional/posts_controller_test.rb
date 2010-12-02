require File.dirname(__FILE__) + '/../test_helper'

class PostsControllerTest < ActionController::TestCase
  fixtures :users, :posts

  def setup
    @admin = User.find(1)
    @jdoe = User.find(2) 
    @admin_post = Post.find(1)
    @jdoe_post = Post.find(2)
    User.current = nil
  end

  context "POST :create" do
    context "by user" do
      setup do
        @request.session[:user_id] = @admin.id
        post :create, :post => { :content => "hy" }
      end
      
      should_redirect_to("/posts") { posts_url }
      should set_the_flash.to "Post was successfully created."
      should "create the post" do
        post = @admin.posts.last
        assert_kind_of Post, post
        assert_equal "hy", post.content
      end
    end
  end


  context "POST :destroy" do
    context "by post owner" do
      setup do
        @request.session[:user_id] = @admin.id
        delete :destroy, :id => @admin_post.id
      end
      
      should_redirect_to("/posts") { posts_url }
      should set_the_flash.to "Post was successfully deleted."
      should "delete the post" do
        assert_nil Post.find_by_id(@admin_post.id)
      end
    end

    context "by post's owner friend" do
      setup do
        @request.session[:user_id] = @admin.id
        delete :destroy, :id => @jdoe_post.id
      end

      should_redirect_to("/posts") { posts_url }
      should set_the_flash.to "Unable to delete post."
      should "not delete the post" do
        post = Post.find_by_id(@jdoe_post.id)
        assert_kind_of Post, post
      end
    end
  end
end
