class FriendshipsController < ApplicationController
  unloadable
  before_filter :require_login

  def create
    @friendship = find_current_user.friendships.build(:friend_id => params[:friend_id])

    if User.find(params[:friend_id]).id == find_current_user.id
      redirect_to(posts_url, :error => "Can't follow yourself." )
    elsif @friendship.save
      redirect_to(posts_url, :notice => "Following request sent.")
    else
      redirect_to(posts_url, :error => "Error sending following request." )
    end
  end

  def destroy
    @friendship = find_current_user.friendships.find(params[:id])
    @friendship.destroy
    redirect_to(posts_url, :notice => "Stopped following user.")
  end

  def accept
    @friendship = find_current_user.inverse_friendships.find(params[:id])
    @friendship.accepted = true
    @friendship.save
    redirect_to(posts_url, :notice => "Following request accepted.")
  end

  def reject
    @friendship = find_current_user.inverse_friendships.find(params[:id])
    @friendship.destroy
    redirect_to(posts_url, :notice => "Following request rejected." )
  end

  def block
    @friendship = find_current_user.inverse_friendships.find(params[:id])
    @friendship.blocked = true
    @friendship.save
    redirect_to(posts_url, :notice => "User sucessfuly blocked.")
  end

  def unblock
    @friendship = find_current_user.inverse_friendships.find(params[:id])
    @friendship.blocked = false
    @friendship.save
    redirect_to(posts_url, :notice => "User sucessfuly unblocked.")
  end
end

