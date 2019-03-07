class AccessController < ApplicationController
  def menu
    if @admin
      @reports = Report.all
    else
      redirect_to dank_path
    end
  end

  def login
    if @current_user
      redirect_to dank_path
    end
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
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Successfully Logged Out."
    redirect_to '/'
  end

  def admin_login
    if @admin
      redirect_to access_menu_path
    end
    if params[:username].present? && params[:password].present?
      found_admin = Admin.where(username: params[:username]).first
      if found_admin
        authorized_admin = found_admin.authenticate(params[:password])
      end
    end
    if authorized_admin
      session[:admin_id] = authorized_admin.id
      flash[:notice] = "You successfully logged in."
      redirect_to access_menu_path
    else
      flash.now[:notice] = "Invalid username/password combination."
    end
  end

  def admin_logout
    session[:admin_id] = nil
    flash[:notice] = "Successfully Logged Out."
    redirect_to '/'
  end

end
