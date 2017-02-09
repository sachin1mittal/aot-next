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

  def add_role
    role = Role.find_by(label: params[:role])
    user = User.find(params[:user_id])
    user.roles.push(role)
    flash[:notice] = 'Successfully Added Role'
    flash.keep
    redirect_to action: :index
  end

  def remove_role
    role = Role.find_by(label: params[:role])
    user = User.find(params[:user_id])
    user.roles.destroy(role)
    flash[:notice] = 'Successfully Removed Role'
    flash.keep
    redirect_to action: :index
  end
end
