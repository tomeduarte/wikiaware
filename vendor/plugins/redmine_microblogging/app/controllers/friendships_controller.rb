class FriendshipsController < ApplicationController
  unloadable

  def create
    @friendship = find_current_user.friendships.build(:friend_id => params[:friend_id])
    logger.info(params[:friend_id])
    logger.info(find_current_user.id)
    if User.find(params[:friend_id]).id == find_current_user.id
        logger.warn("here");
      flash[:error] = "Can't follow yourself."
      redirect_to posts_url
    elsif @friendship.save
      flash[:notice] = "Following request sent."
      redirect_to posts_url
    else
      flash[:error] = "Error sending following request."
      redirect_to posts_url
    end
  end

  def destroy
    @friendship = find_current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Stopped following user."
    redirect_to posts_url
  end

  def accept
    @friendship = find_current_user.inverse_friendships.find(params[:id])
    @friendship.accepted = true
    @friendship.save
    flash[:notice] = "Following request accepted."
    redirect_to posts_url
  end

  def reject
    @friendship = find_current_user.inverse_friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Following request rejected."
    redirect_to posts_url
  end

  def block
    @friendship = find_current_user.inverse_friendships.find(params[:id])
    @friendship.blocked = true
    @friendship.save
    flash[:notice] = "User sucessfuly blocked."
    redirect_to posts_url
  end
end

