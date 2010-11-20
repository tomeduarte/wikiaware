class FriendshipsController < ApplicationController
  unloadable

  def create
    @friendship = find_current_user.friendships.build(:friend_id => params[:friend_id])
    if params[:friend_id] == find_current_user.id
      flash[:error] = "Can't follow yourself."
      redirect_to root_url
    end
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end

  def destroy
    @friendship = find_current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to root_url
  end
end

