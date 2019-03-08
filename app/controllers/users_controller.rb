class UsersController < ApplicationController
  layout 'user'
  before_action :set_user, only: [:update, :show]
  before_action :user_params, only: [:create, :update]
  before_action :set_current_user

  def new
    if @current_user
      redirect_to dank_path
    end
  @user = User.new
  end

  def create
    user = User.new(user_params)
    byebug
    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to new_user_path
    end

  end

  def show
    set_user
    set_current_user
    @posts = @user.posts.reverse
  end

  def destroy
    set_user
    @user.destroy
    redirect_to dank_path
  end

  def edit
    set_user
    set_current_user
    unless @current_user == @user.id
      redirect_to edit_user_path(@current_user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to @user
  end

  private


  def user_params
    params.require(:user).permit(:username, :display_name, :admin, :password, :password_confirmation, :avatar_url, :bio, :location)
  end
end
