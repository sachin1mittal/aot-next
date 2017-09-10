class RolesController < ApplicationController

  before_action :set_role, only: [:edit, :update, :destroy]

  def create
    Role.create!(params_attributes)
    flash[:success] = 'Successfully Created Role'
    redirect_to roles_path
  end

  def new
    @role = Role.new
  end

  def update
    @role.update_attributes!(params_attributes)
    flash[:success] = 'Successfully Updated Role'
    redirect_to roles_path
  end

  def edit
  end

  def index
    @roles = Role.all
  end

  def destroy
    @role.destroy!
    flash[:success] = 'Successfully Deleted Role'
    redirect_to roles_path
  end

  private

  def params_attributes
    params.require(:role).permit(:label, permission_ids: [])
  end

  def set_role
    @role ||= Role.find(params[:id])
  end

end
