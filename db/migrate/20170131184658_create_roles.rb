class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :label
      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
