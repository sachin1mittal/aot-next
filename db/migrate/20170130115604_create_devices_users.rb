class CreateDevicesUsers < ActiveRecord::Migration
  def change
    create_table :devices_users do |t|
      t.references :users, index: true
      t.references :devices, index: true
      t.string :role
      t.boolean :currently_accessible
    end
  end
end
