class UserSessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      if @user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to feed_posts_path
      end

    else
      redirect_to new_user_session_path, notice: "Incorrect email or password!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
