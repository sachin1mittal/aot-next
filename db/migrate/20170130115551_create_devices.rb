class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :token
      t.string :password
      t.string :status
      t.string :usage_type
      t.string :api
      t.string :user_provided_name
      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
