class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string :name
      t.string :description
      t.string :password
      t.string :slug
      t.references :user, index: true
      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
