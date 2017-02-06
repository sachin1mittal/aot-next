class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.text :description
      t.string :barcode
      t.string :token
      t.string :password
      t.string :status
      t.string :usage_type
      t.string :current_ip
      t.string :user_provided_name
      t.text :user_provided_description
      t.string :otp_token
      t.datetime :otp_token_expiry
      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
