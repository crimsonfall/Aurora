class FollowsController < ApplicationController
  def create
    @user = User.find(params[:id])
    current_user.followed_users << @user unless current_user.followed_users.include?(@user)
    redirect_to @user
  end

  def destroy
    @user = User.find(params[:id])
    current_user.followed_users.delete(@user)
    redirect_to @user
  end
  
end
