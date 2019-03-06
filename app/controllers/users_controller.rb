class UsersController < ApplicationController
  layout 'user'
  before_action :set_user, only: [:update, :show]
  before_action :user_params, only: [:create, :update]
  before_action :set_current_user

  def new
  @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:notice] = "Your password and password confirmation did not match"
      redirect_to new_user_path
    end

  end

  def show
    set_user
    set_current_user
    @posts = @user.posts
  end

  def index

  end

  def edit
    set_user
    set_current_user
    unless @current_user == @user
      redirect_to edit_user_path(@current_user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to @user
  end

  private


  def user_params
    params.require(:user).permit(:username, :display_name, :admin, :password, :password_confirmation, :avatar, :bio, :location)
  end
end
