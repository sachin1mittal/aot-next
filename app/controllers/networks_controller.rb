class NetworksController < ApplicationController

  # before_action :set_network, only: [:edit, :update, :destroy, :add_device, :remove_device]

  # def index
  #   @networks = current_user.networks
  # end

  # def new
  #   @network = Network.new
  # end

  # def edit
  #   @devices_without_network = current_user.owned_devices.where(network_id: nil)
  # end

  # def add_device
  #   @network.devices.push(device)
  #   flash[:success] = 'Device Added to this network'
  #   redirect_to edit_network_path(@network)
  # end

  # def remove_device
  #   device.update_attributes!(network_id: nil)
  #   flash[:success] = 'Device Removed from this network'
  #   redirect_to edit_network_path(@network)
  # end

  # def create
  #   network = current_user.networks.create(params_attributes)
  #   flash[:success] = 'Network Added Successfully'
  #   redirect_to networks_path
  # end

  # def update
  #   @network.update(params_attributes)
  #   flash[:success] = 'Network Updated Successfully'
  #   redirect_to networks_path
  # end

  # def destroy
  #   @network.destroy
  #   flash[:success] = 'Network has been Successfully Removed'
  #   redirect_to networks_path
  # end

  # private

  # def device
  #   @device ||= current_user.owned_devices.find_by_slug!(params[:device_id] || params[:id])
  # end

  # def params_attributes
  #   params.require(:network).permit(:name, :description, :password)
  # end

  # def set_network
  #   @network ||= Network.find_by_slug!(params[:network_id] || params[:id])
  # end
end
