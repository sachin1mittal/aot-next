class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if current_user.update(params_attribute)
      user_manager.update_password(params[:password])
      render :show, success: 'Profile Updated Successfully'
    else
      render :edit, danger: user_errors(current_user)
    end
  end

  def change_token
    if user_manager.change_token
      render :show, success: 'Secret Token Updated Successfully'
    else
      render :edit, danger: user_errors(current_user)
    end
  end

  def destroy
    if current_user.destroy
      session[:user_id] = nil
      redirect_to root_path
    else
      render :show, danger: user_errors(current_user)
    end
  end

  def add_role
    role = Role.find_by(label: params[:role])
    user = User.find(params[:user_id])
    user.roles.push(role)
    flash[:success] = 'Successfully Added Role'
    flash.keep
    redirect_to action: :index
  end

  def remove_role
    role = Role.find_by(label: params[:role])
    user = User.find(params[:user_id])
    user.roles.destroy(role)
    flash[:success] = 'Successfully Removed Role'
    flash.keep
    redirect_to action: :index
  end

  private

  def user_manager
    @user_manager ||= UserManager.new(current_user)
  end

  def params_attributes
    params.require(:user).permit(:name, :photo)
  end

  def user_errors(user)
    user.errors.messages.map{|key, value| key.to_s + ' ' + value.join(', ') }.join(', ')
  end
end
