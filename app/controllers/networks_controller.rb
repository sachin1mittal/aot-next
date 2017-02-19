class NetworksController < ApplicationController

  before_action :set_network, only: [:edit, :update, :destroy, :add_device, :remove_device]

  def index
    @networks = current_user.networks
  end

  def new
    @network = Network.new
  end

  def edit
    @devices_without_network = current_user.owned_devices.where(network_id: nil)
  end

  def add_device
    @network.devices.push(device)
    redirect_to edit_network_path(@network), success: 'Device Added to this network'
  end

  def remove_device
    device.update_attributes!(network_id: nil)
    redirect_to edit_network_path(@network), success: 'Device Removed from this network'
  end

  def create
    network = current_user.networks.create(params_attributes)
    redirect_to networks_path, success: 'Network Added Successfully'
  end

  def update
    @network.update(params_attributes)
    redirect_to networks_path, success: 'Network Updated Successfully'
  end

  def destroy
    @network.destroy
    redirect_to networks_path, success: 'Network has been Successfully Removed'
  end


  private

  def device
    @device ||= current_user.owned_devices.find_by_slug(params[:device_id] || params[:id])
  end

  def params_attributes
    params.require(:network).permit(:name, :description, :password)
  end

  def set_network
    @network ||= Network.find(params[:network_id] || params[:id])
  end
end
