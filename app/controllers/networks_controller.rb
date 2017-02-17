class NetworksController < ApplicationController

  before_action :set_network, only: [:edit, :update, :destroy]

  def index
    @networks = current_user.networks
  end

  def new
    @network = Network.new
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

  def params_attributes
    params.require(:network).permit(:name, :description, :password)
  end

  def set_network
    @network ||= Network.find(params[:id])
  end
end
