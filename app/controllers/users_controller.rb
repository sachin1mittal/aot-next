class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :destroy, :update]

  def index
    @users = User.all
  end

  def edit
  end

  def update
    @user.update_attributes!(params_attributes)
    flash[:success] = 'Successfully Updated User'
    redirect_to :back
  end

  def destroy
    @user.destroy!
    flash[:success] = 'Successfully Destroyed User'
    redirect_to :back
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

  private

  def user_manager
    @user_manager ||= UserManager.new(current_user)
  end

  def params_attributes
    if current_user.admin?
      params.require(:user).permit(:name, :photo, role_ids: [])
    else
      params.require(:user).permit(:name, :photo)
    end
  end

  def set_user
    if current_user.admin?
      @user ||= User.find_by_slug!(params[:device_id] || params[:id])
    else
      @user ||= current_user
    end
  end
end
