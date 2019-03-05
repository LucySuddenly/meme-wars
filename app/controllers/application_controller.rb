class ApplicationController < ActionController::Base
  helper_method :set_user
  helper_method :set_current_user

  def set_user
    @user = User.find(params[:id])
  end


  def set_current_user
    @current_user = session[:user_id]
  end
end
