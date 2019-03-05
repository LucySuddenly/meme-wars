class PostsController < ApplicationController

  def index
    @posts = Post.all

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
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :user_id)
  end
end
