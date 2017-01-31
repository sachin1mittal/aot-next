class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, index: true, unique: true
      t.string :phone_number, index: true, unique: true
      t.string :password, null: false, unique: true
      t.string :token, null: false
      t.string :otp_token
      t.datetime :otp_token_expiry
      t.datetime :deleted_at, index: true
      t.attachment :photo
      t.timestamps null: false
    end
  end
end
