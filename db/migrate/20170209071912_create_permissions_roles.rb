class CreatePermissionsRoles < ActiveRecord::Migration
  def change
    create_table :permissions_roles, id: false do |t|
      t.references :permission, index: true
      t.references :role, index: true
    end
  end
end
