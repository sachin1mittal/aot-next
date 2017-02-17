class DevicesController < ApplicationController

  before_action :set_owned_device, only: [:edit, :update, :add_user, :remove_user, :download_script]
  before_action :set_device, only: [:show, :create, :destroy]

  def index
    @devices = filtered_devices
  end

  def new
    @device = Device.new
  end

  def create
    device = current_user.owned_devices.create(params_attributes)
    redirect_to device_path(device), success: 'Device Added Successfully'
  end

  def update
    @owned_device.update(params_attributes)
    redirect_to device_path(@owned_device), success: 'Device Updated Successfully'
  end

  def destroy
    owned_device_manager.remove_user(current_user)
    redirect_to devices_path, success: 'Device has been Successfully Removed'
  end

  def toggle
    param! :state, String, in: %w(on off)
    device_manager.toggle
    render json: {}
  end

  def add_user
    param! :uid, String, required: true, blank: false
    user = User.find_by_uid(params[:uid])
    owned_device_manager.add_user(user)
    redirect_to device_path, success: 'User has been Successfully Added'
  end

  def remove_user
    param! :uid, String, required: true, blank: false
    user = User.find_by_uid(params[:uid])
    owned_device_manager.remove_user(user)
    redirect_to device_path, success: 'User has been Successfully Removed'
  end

  def script
    data = owned_device_manager.get_microcontroller_script
    send_data data, filename: "script.cpp"
  end

  private

  def owned_devices
    current_user.owned_devices
  end

  def shared_devices
    current_user.shared_devices
  end

  def joined_errors(object)
    object.errors.messages.map { |key, value| key.to_s + ' ' + value.join(', ') }.join(', ')
  end

  def set_owned_device
    @owned_device ||= current_user.owned_devices.find(params[:id] || params[:device_id])
  end

  def set_shared_device
    @shared_device ||= current_user.shared_devices.find(params[:id] || params[:device_id])
  end

  def set_device
    @device ||= current_user.devices.find(params[:id] || params[:device_id])
  end

  def params_attributes
    params.require(:device).permit(:name, :network_id)
  end

  def device_manager
    @device_manager ||= DeviceManager.new(@device)
  end

  def owned_device_manager
    @owned_device_manager ||= DeviceManager.new(@owned_device)
  end

  def filtered_devices
    if params[:category].present?
      case params[:category]
      when 'shared'
        shared_devices
      when 'owned'
        owned_devices
      else
        current_user.devices
      end
    elsif params[:network_id].present?
      Network.find(params[:network_id]).devices
    end
  end
end
