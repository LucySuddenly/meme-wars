class AccessController < ApplicationController
  def menu
  end

  def login

    if params[:username].present? && params[:password].present?
      found_user = User.where(username: params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "You successfully logged in."
      redirect_to user_path(authorized_user)
    else
      flash.now[:notice] = "Invalid username/password combination."
      render('login')
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Successfully Logged Out."
    redirect_to '/'
  end
end
