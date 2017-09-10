class CreateDevicesUsers < ActiveRecord::Migration
  def change
    create_table :devices_users do |t|
      t.references :user, index: true
      t.references :device, index: true
      t.datetime :deleted_at, index: true
      t.string :role
      t.timestamps null: false
    end
  end
end
