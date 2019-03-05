class PostsController < ApplicationController

  def index
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

  end

  def post_params
    params.require(:post).permit(:title, :image, :user_id)
  end
end
