class PostsController < ApplicationController
  unloadable
  layout 'base'

  def index
    @posts = Post.find(:all)
  end

  def create
  end

  def new
  end

  def destroy
  end

  def show
  end
end

