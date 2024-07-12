class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
    @users = User.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def withdrawal
    @user = User.find(params[:user_id])
    @user.update(is_active: false)
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :introduction)
  end
end
