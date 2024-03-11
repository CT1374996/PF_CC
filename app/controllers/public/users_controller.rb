class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  def show
    # @user = current_user
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールを変更しました"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def index
    # @user = User.find(params[:id])
    @impressions = @user.impressions
  end

  def favorites
    @user = current_user
    @favorite_impressions = @user.favorites.includes(:impression)
    render 'favorites'
  end

  def confirm
    @user = current_user
  end

  def withdrawal
    @user = current_user
    @user.update(is_active: false)
    reset_session
    # redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :email)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end



end
