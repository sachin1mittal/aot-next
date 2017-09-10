class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :slug
      t.string :serial_number
      t.string :status
      t.string :owner_status
      t.references :network, index: true
      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
