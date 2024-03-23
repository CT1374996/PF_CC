class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :is_matching_login_user, only: [:edit, :update]
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
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def index
    @user = User.find(params[:user_id])
    # @impressions = @user.impressions
    @impressions = Impression.where(user_id: @user.id).order(created_at: :desc)
    # @impressions = Impression.where(user_id: @user.id)
    # @impressions = Impression.order(created_at: :desc)
  end

  def favorites
    @user = User.find(params[:user_id])
    @favorite_impressions = Impression.joins(:favorites).where(favorites: {user_id: @user.id})
    @impressions = Impression.order(created_at: :desc)
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
    params.require(:user).permit(:name, :like_game, :introduction, :email)
  end

  #def is_matching_login_user
    #user = User.find(params[:id])
    #unless user.id == current_user.id
      #redirect_to user_path(current_user)
   # end
  #end



end
