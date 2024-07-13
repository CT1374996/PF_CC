class Public::ImpressionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  def index
    @impressions = Impression.all
    @impressions = Impression.order(created_at: :desc)
  end

  def new
    @impression = Impression.new
  end

  def create
    @impression = Impression.new(impression_params)
    @impression.user_id = current_user.id
    if @impression.save
      flash[:notice] = "投稿しました"
      redirect_to impression_path(@impression.id)
    else
      render :new
    end
  end

  def show
    @impression = Impression.find(params[:id])
    @comment = Comment.new
    @user = @impression.user
  end

  def edit
    @impression = Impression.find(params[:id])
  end

  def update
    @impression = Impression.find(params[:id])
    if @impression.update(impression_params)
      flash[:notice] = "編集しました"
      redirect_to impression_path(@impression.id)
    else
      render :edit
    end
  end

  def destroy
    impression = Impression.find(params[:id])
    impression.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to user_path(current_user.id)
  end

  private
  def impression_params
    params.require(:impression).permit(:title, :body)
  end

  def correct_user
    @impression = Impression.find(params[:id])
    @user = @impression.user
    unless @user == current_user
      redirect_to root_path
    end
  end
end
