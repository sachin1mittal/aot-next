class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_table :roles_users, id: false do |t|
      t.references :user, index: true
      t.references :role, index: true
    end
  end
end
