class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @impression = Impression.find(params[:impression_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.impression_id = @impression.id
    comment.save
    @impression.create_notification_comment!(current_user, @comment.id)
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
