class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(customer_params)
      redirect_to users_mypage_path(current_user)
    else
      render :edit
    end
  end

  def confirm
    @user = current_user
  end

  def withdrawal
    @user = current_user
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :email)
  end
end
