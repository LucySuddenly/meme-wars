class UsersController < ApplicationController
  layout 'user'
  before_action :set_user, only: [:update, :show]
  before_action :user_params, only: [:create, :update]

  def new
  @user = User.new
  end

  def create
    user = User.create(user_params)
    redirect_to user_path(user)
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
