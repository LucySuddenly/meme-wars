class ReportsController < ApplicationController

  before_action :load_reportable, only: [:new, :create]

  def new
    session[:return_page] = request.referrer
    @report = @reportable.reports.new
  end

  def create
    @report = @reportable.reports.new(report_params)
    if @report.save
      redirect_to session[:return_page]
    else
      redirect_to :new
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to access_menu_path
  end

  private



  def report_params
    params.require(:report).permit(:content, :user_id)
  end
end
