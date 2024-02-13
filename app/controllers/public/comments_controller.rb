class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @impression = Impression.find(params[:impression_id])
    @comment = current_user.impression_comments.new(impression_params)
    @comment.impression_id = imression_id
    comment.save
    redirect_to impression_path(@impression.id)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to impression_path(params[:impression_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
