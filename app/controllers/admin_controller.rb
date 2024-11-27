class AdminController < ApplicationController
  before_action :ensure_admin

  def dashboard
  end

  private

  def ensure_admin
    redirect_to root_path unless current_user.admin?
  end
end
