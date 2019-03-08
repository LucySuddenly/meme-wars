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
    params.require(:post).permit(:title, :image_url, :user_id)
  end
end
