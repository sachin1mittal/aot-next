class UsersController < ApplicationController

  skip_before_action :authenticate_user, only: :login

  def login
    if session[:user_id].present?
      redirect_to root_path, notice: 'You Are Already Logged In'
    end
  end

  def index
    @users = User.all
  end
end
