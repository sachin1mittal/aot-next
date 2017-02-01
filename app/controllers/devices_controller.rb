class DevicesController < ApplicationController

  # before_action :set_user, only: [:show, :edit, :destroy]

  def index
    @devices = current_user.devices
  end

  # def create
  #   @user =
  #   respond_to do |format|
  #     format.html
  #     format.json { render json: @user }
  #   end
  # end

  # def update
  #   object = model.find(params[:id])
  #   object.update_attributes!(params_attributes)
  #   render_serializer(scope: object)
  # end

  # def destroy
  #   model.find(params[:id]).destroy
  #   api_render json: {}, status: :ok
  # end

  # def show
  #   respond_to do |format|
  #     format.html
  #     format.json { render json: @user }
  #   end
  # end

  # private

  # def params_attributes
  #   params.require(:user).permit()
  # end

  # def set_user
  #   @user = User.find(params[:id])
  # end
end
