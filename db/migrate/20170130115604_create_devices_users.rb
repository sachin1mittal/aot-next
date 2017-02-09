class CreateDevicesUsers < ActiveRecord::Migration
  def change
    create_table :devices_users do |t|
      t.references :user, index: true
      t.references :device, index: true
      t.string :role
      t.boolean :currently_accessible
      t.timestamps null: false
    end
  end
end
