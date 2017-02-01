class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :uid
      t.string :provider
      t.string :oauth_token
      t.string :email, index: true
      t.string :phone_number, index: true
      t.string :password
      t.datetime :oauth_expires_at
      t.datetime :deleted_at, index: true
      t.attachment :photo
      t.timestamps null: false
    end
  end
end
