class CreateAwsThing < ActiveRecord::Migration
  def change
    create_table :aws_things do |t|
      t.references :device, index: true
      t.string :name
      t.string :arn
      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
