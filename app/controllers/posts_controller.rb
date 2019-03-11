class PostsController < ApplicationController

  def index
    redirect_to dank_path
  end

  def dank
    @posts = Post.sort_by_dank
  end

  def top
    @posts = Post.sort_by_top
  end

  def fresh
    @posts = Post.sort_by_new
  end

  def new
    set_current_user
    @post = Post.new
    session[:user_id] = @current_user
  end

  def create
    post = Post.new(post_params)
    if post.valid?
      post.save
      redirect_to post
    else
      flash[:notice] = "You must attach an image."
      redirect_to new_post_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    begin
    @post.destroy
    rescue
    end
    redirect_to '/'
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.sort_by {|comment| comment.likes.count}
    @comments = @comments.reverse
    set_current_user
  end

  private

  def post_params
    params.require(:post).permit(:title, :image_url, :user_id)
  end
end
