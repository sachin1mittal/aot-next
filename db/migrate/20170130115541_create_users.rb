class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :uid
      t.string :provider
      t.string :slug
      t.string :secret_token
      t.string :password
      t.string :oauth_token
      t.string :email, index: true
      t.datetime :oauth_expires_at
      t.datetime :deleted_at, index: true
      t.attachment :photo
      t.timestamps null: false
    end
  end
end
