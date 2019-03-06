class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    # Comment.create(comment_params)
    # redirect_to request.referrer
    @comment = @commentable.comments.new comment_params

    if @comment.save
      redirect_to request.referrer, notice: 'Your comment was successfully posted!'
    else
      redirect_to request.referrer, notice: "Your comment wasn't posted!"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to post_path(@comment.commentable_id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    post_id = @comment.commentable_id
    @comment.destroy
    redirect_to post_path(post_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type, :user_id)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end
end
