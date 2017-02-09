class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user
  before_action :authenticate_user
  before_action :set_paper_trail_whodunnit

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    if session[:user_id].nil?
      redirect_to login_path
    elsif not current_user.permitted?(params[:controller], params[:action])
      flash[:alert] = 'You Dont Have Permission to access this page'
      flash.keep
      redirect_to root_path
    end
  end
end
