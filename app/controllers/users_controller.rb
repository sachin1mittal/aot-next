class UsersController < ApplicationController

  # def index
  #   @users = User.all
  # end

  # def edit
  # end

  def help
    param! :category, String, required: true, blank: false, in: %w(node embedded_c)
    render "devices/connectivity/#{params[:category]}"
  end

  def dashboard
    @owned_devices = current_user.owned_devices
    @shared_devices = current_user.shared_devices
    # @networks = current_user.networks
    @shared_users = current_user.shared_users
    @all_devices = current_user.devices
  end

  def search_by_email
    param! :email, String, required: true, blank: false
    param! :device_slug, String, required: true, blank: false
    @user = User.find_by_email!(params[:email])
    @device = current_user.devices.find_by_slug!(params[:device_slug])
    @already_user = @user.devices.pluck(:id).include?(@device.id) if @user.present?
  end

  # def update
  #   current_user.update(params_attribute)
  #   user_manager.update_password(params[:password])
  #   flash[:success] = 'Profile Updated Successfully'
  #   render :show
  # end

  # def change_token
  #   user_manager.change_token
  #   flash[:success] = 'Secret Token Updated Successfully'
  #   render :show
  # end

  # def destroy
  #   session[:user_id] = nil
  #   flash[:success] = 'You have beed logged out'
  #   redirect_to root_path
  # end

  # def add_role
  #   role = Role.find_by(label: params[:role])
  #   user = User.find(params[:user_id])
  #   user.roles.push(role)
  #   flash[:success] = 'Successfully Added Role'
  #   flash.keep
  #   redirect_to action: :index
  # end

  # def remove_role
  #   role = Role.find_by(label: params[:role])
  #   user = User.find(params[:user_id])
  #   user.roles.destroy(role)
  #   flash[:success] = 'Successfully Removed Role'
  #   flash.keep
  #   redirect_to action: :index
  # end

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
