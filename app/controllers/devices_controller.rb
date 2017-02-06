class DevicesController < ApplicationController

  before_action :set_device, only: [:edit, :update, :destroy, :toggle]

  def index
    @devices = devices
  end

  def new
    @device = Device.new
  end

  def create
    @device = current_user.devices.create(params_attributes)
    if @device.persisted?
      redirect_to devices_path, notice: 'Device Added Successfully'
    else
      flash.now[:alert] = device_errors
      render :new
    end
  end

  def update
    if @device.update(params_attributes)
      redirect_to devices_path, notice: 'Device Updated Successfully'
    else
      flash.now[:alert] = device_errors
      render :edit
    end
  end

  def destroy
    if @device.destroy
      redirect_to devices_path, notice: 'Device has been Successfully Removed'
    else
      redirect_to devices_path, alert: device_errors
    end
  end

  def toggle
    response = DeviceManager.new(@device).toggle(params[:state])
    if response[:success] == true
      #render js  with positive response
    else
      #render js  with negative response
    end
  end

  private

  def devices
    if current_user.admin? && params[:all_devices] == 'yes'
      @all_devices = true
      Device.all
    else
      current_user.devices
    end
  end

  def device_errors
    @device.errors.messages.map{|key, value| key.to_s + ' ' + value.join(', ') }.join(', ')
  end

  def set_device
    if current_user.admin?
      @device ||= Device.find(params[:id] || params[:device_id])
    else
      current_user.devices.find(params[:id] || params[:device_id])
    end
  end

  def params_attributes
    params.require(:device).permit(:user_provided_name, :token, :password, :current_ip)
  end
end
