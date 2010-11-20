class PostsController < ApplicationController
  unloadable
  before_filter :require_login

  # GET /posts
  # GET /posts.xml
  def index
    @user = find_current_user
    timeline = []
    @user.friends.each do |friend|
      friend.posts.each do |post|
        timeline << {:user => friend, :post => post}
      end
    end
    @user.posts.each do |p| timeline << {:user => @user, :post => p} end
    @timeline = timeline.sort_by{ |line| -line[:post].created_at.to_i }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.user = find_current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to(posts_url, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url, :notice => 'Post was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end

