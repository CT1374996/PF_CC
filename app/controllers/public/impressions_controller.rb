class Public::ImpressionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  def index
    @impressions = Impression.all
  end

  def new
    @impression = Impression.new
  end

  def create
    @impression = Impression.new(impression_params)
    if @impression.save
      flash[:notice] = "投稿しました"
      redirect_to impression_path(@impression.id)
    else
      render :new
    end
  end

  def show
    @impression = Impression.find(params[:id])
  end

  def edit
    @impression = Impression.find(params[:id])
    @impression.user_id = current_user.id
    @user = @impression.user
  end

  def update
    @impression = Impression.find(params[:id])
    if @impression.update(impression_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to impression_path(@impression.id)
    else
      render :edit
    end
  end

  def destroy
    impression = Inmpression.find(params[:id])
    impression.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to users_mypage_path
  end

  private
  def impression_params
    params.require(:impression).permit(:title, :body)
  end
end
