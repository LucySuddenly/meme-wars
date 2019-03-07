class ApplicationController < ActionController::Base
  helper_method :set_user
  helper_method :set_current_user
  before_action :set_admin
  before_action :set_current_user
  before_action :load_reportable, except: [:dank, :fresh, :top, :menu, :login, :logout, :admin_login, :index, :new, :posts, :create]

  def set_user
    @user = User.find(params[:id])
  end

  def set_current_user
    @current_user = session[:user_id]
  end

  def set_admin
    @admin = session[:admin_id]
  end

  def load_reportable
    resource, id = request.path.split('/')[1,2]
    @reportable = resource.singularize.classify.constantize.find(id)
  end
end
