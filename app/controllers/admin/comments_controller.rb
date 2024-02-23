class Admin::CommentsController < ApplicationController
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_impression_path(params[:impression_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
