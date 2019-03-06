class PostsController < ApplicationController

  def index
    redirect_to dank_path
  end

  def dank
    @posts = Post.all
    @posts = sort_by_dank(@posts)
  end

  def top
    @posts = Post.all
    @posts = sort_by_top(@posts)
  end

  def fresh
    @posts = Post.all
    @posts = sort_by_new(@posts)
  end

  def new
    @post = Post.new
    session[:user_id] = 1
  end

  def create
    post = Post.create(post_params)
    redirect_to post
  end

  def destroy

  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.sort_by {|comment| comment.likes.count}
    @comments = @comments.reverse
    set_current_user
  end

  private

  def sort_by_new(sortable)
    sortable.sort_by do |item|
      item.created_at
    end.reverse
  end

  def sort_by_top(sortable)
     sortable.sort_by do |item|
       item.likes.count
     end.reverse
  end

  def sort_by_dank(sortable)
    sortable.sort_by do |item|
      ((Time.now.to_i - item.updated_at.to_i) / 60 / 60).to_f - item.likes.count.to_f
    end
  end

  def post_params
    params.require(:post).permit(:title, :image, :user_id)
  end
end
