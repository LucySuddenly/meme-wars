class PostsController < ApplicationController

  def index
    @posts = Post.all
    @posts = sort_by_top(@posts).reverse
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
    set_current_user
  end

  private

  def sort_by_new(sortable)
  end

  def sort_by_top(sortable)
     sortable.sort_by do |item|
       item.likes.count
     end
  end

  def sort_by_dank

  end

  def post_params
    params.require(:post).permit(:title, :image, :user_id)
  end
end
