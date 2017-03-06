class SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: [:create, :login]

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    render_response(
      redirect_path: root_path
    )
  end

  def destroy
    session[:user_id] = nil
    render_response(
      redirect_path: root_path
    )
  end

  def login
    if session[:user_id].present?
      flash[:success] = 'You Are Already Logged In'
      redirect_to root_path
    end
    render layout: false
  end
end
