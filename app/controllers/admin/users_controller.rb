class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
    @users = User.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
      flash[:notice] = "#{@user.name}さんの会員ステータスを更新しました"
    else
      render :edit
    end
  end

  def withdrawal
    @user = User.find(params[:user_id])
    @user.update(is_active: false)
    redirect_to admin_reports_path
    flash[:notice] = "#{@user.name}さんを強制的に退会させました"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :like_game, :introduction, :user_status)
  end
end
