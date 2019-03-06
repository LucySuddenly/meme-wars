class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    Comment.create(comment_params)
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type, :user_id)
  end
end
