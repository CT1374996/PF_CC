class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    # @user = User.find_by(name: params[:name], email: params[:email])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "プロフィールを変更しました"
      redirect_to users_mypage_path(current_user)
    else
      render :edit
    end
  end

  def index
    @user = current_user
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
end
