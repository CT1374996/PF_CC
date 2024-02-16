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
    @impression.user_id = current_user.id
    if params[:post]
      if @impression.save(context: :publicize)
        redirect_to impression_path(@impression.id), notice: "投稿しました"
      else
        render :new, alert: "投稿できませんでした"
      end
    else
      if @impression.update(is_draft: true)
        redirect_to users_mypage_path(current_user), notice: "下書きを保存しました"
      else
        render :new, alert: "保存できませんでした"
      end
    end
  end

  def show
    @impression = Impression.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @impression = Impression.find(params[:id])
    @impression.user_id = current_user.id
    @user = @impression.user
  end

  def update
    @impression = Impression.find(params[:id])
    if params[:publicize_draft]
      @impression.attributes = impression_params
      if @impression.save(context: :publicize)
        redirect_to post_impression_path(@impression.id), notice: "投稿しました"
      else
        @impression.is_draft = true
      render :edit, alert: "投稿しませんでした"
      end
    elsif params[:update_post]
      @impression.attributes = impression_params
      if impression.save(context: :publicize)
        redirect_to post_impression_path(@impression.id), notice: "内容を更新しました"
      else
        render :edit, alert: "更新できませんでした"
      end
    else
      if @impression.update(impression_params)
        redirect_to impression_path(@impression.id), notice: "下書きを更新しました"
      else
        render :edit, alert: "下書きが更新されませんでした"
      end
    end
  end

  def destroy
    impression = Impression.find(params[:id])
    impression.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to users_mypage_path
  end

  private
  def impression_params
    params.require(:impression).permit(:title, :body)
  end
end
