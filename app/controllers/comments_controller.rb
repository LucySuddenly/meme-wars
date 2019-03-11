class CommentsController < ApplicationController
  before_action :find_commentable
  before_action :find_comment, only: [:show, :update, :destroy, :edit]

  def new
    @comment = Comment.new
  end

  def show
    if !session[:admin_id]
      redirect_to dank_path
    end
  end

  def create
    @comment = @commentable.comments.new comment_params
    @comment.save
    redirect_to request.referrer
  end

  def edit
  end

  def update
    @comment.update(comment_params)
    redirect_to post_path(@comment.commentable_id)
  end

  def destroy

    @comment.destroy
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type, :user_id)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
