class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.text :description
      t.string :model
      t.string :brand
      t.string :manufactured_by
      t.date :manufacturing_date
      t.string :barcode
      t.decimal :cost_to_company, precision: 5, scale: 2
      t.string :selling_status
      t.string :working_status
      t.string :usage_type
      t.string :current_ip
      t.datetime :first_used
      t.datetime :last_used
      t.string :user_provided_name
      t.text :user_provided_description
      t.string :otp_token
      t.datetime :otp_token_expiry
      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
