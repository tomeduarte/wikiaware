class PostsController < ApplicationController
  unloadable
  before_filter :require_login

  # GET /posts
  def index
    @post = Post.new
    @user = find_current_user
    @search_results = User.search(params[:search])
    timeline = []
    @user.friends.each do |friend|
      friend.posts.each do |post|
        timeline << {:user => friend, :post => post}
      end
    end
    @user.posts.each do |p| timeline << {:user => @user, :post => p} end
    @timeline = timeline.sort_by{ |line| -line[:post].created_at.to_i }
  end

  # POST /posts
  def create
    @post = Post.new(params[:post])
    @post.user = find_current_user

    if @post.save
      redirect_to(posts_url, :notice => 'Post was successfully created.')
    else
      render :action => "new"
    end
  end

  # DELETE /posts/1
  def destroy
    begin
      @post = find_current_user.posts.find(params[:id])
      @post.destroy

      redirect_to(posts_url, :notice => 'Post was successfully deleted.')
    rescue ActiveRecord::RecordNotFound
      redirect_to(posts_url, :error => 'Unable to delete post.')
    end
  end
end

