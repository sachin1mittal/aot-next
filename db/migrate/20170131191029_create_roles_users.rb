class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_table :roles_users do |t|
      t.references :users, index: true
      t.references :roles, index: true
    end
  end
end
