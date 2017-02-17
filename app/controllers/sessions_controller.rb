class SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: [:create, :login]

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def login
    if session[:user_id].present?
      redirect_to root_path, success: 'You Are Already Logged In'
    end
  end
end
