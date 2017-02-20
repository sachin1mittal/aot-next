class DevicesController < ApplicationController

  before_action :set_device, only: [:destroy, :toggle]
  before_action :set_owned_device, only: [:edit, :update, :add_user, :remove_user, :script, :show]

  def index
    @devices = filtered_devices.includes(:network)
  end

  def new
    @device = Device.new
  end

  def create
    device = current_user.owned_devices.create(params_attributes)
    flash[:success] = 'Successfully created device'
    redirect_to devices_path(category: :all)
  end

  def update
    @owned_device.update(params_attributes)
    flash[:success] = 'Successfully updated device'
    redirect_to devices_path(category: :all)
  end

  def destroy
    device_manager.remove_user(current_user)
    flash[:success] = 'Success removed device'
    redirect_to devices_path(category: :all)
  end

  def toggle
    param! :state, String, in: %w(on off)
    device_manager.toggle
    render json: { success: :true }
  end

  def add_user
    param! :email, String, required: true, blank: false
    user = User.find_by_email!(params[:email])
    owned_device_manager.add_user(user)
    flash[:success] = 'Successfully added user'
    redirect_to device_path(@owned_device)
  end

  def remove_user
    param! :email, String, required: true, blank: false
    user = User.find_by_email!(params[:email])
    owned_device_manager.remove_user(user)
    flash[:success] = 'Successfully removed user'
    redirect_to device_path(@owned_device)
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
    @owned_device ||= current_user.owned_devices.find_by_slug!(params[:device_id] || params[:id])
  end

  def set_shared_device
    @shared_device ||= current_user.shared_devices.find_by_slug!(params[:device_id] || params[:id])
  end

  def set_device
    @device ||= current_user.devices.find_by_slug!(params[:device_id] || params[:id])
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
    else
      current_user.devices
    end
  end
end
