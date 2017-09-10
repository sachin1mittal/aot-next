class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :controller
      t.string :action
      t.string :status
      t.string :category
      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
