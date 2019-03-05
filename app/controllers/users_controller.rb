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
  end

  def index

  end

  def edit
    set_user
    unless @current_user == @user
      redirect_to edit_user_path(@current_user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :display_name, :admin, :password_digest, :avatar, :bio, :location)
  end

  def set_current_user
    @current_user = session[:user_id]
  end
end
