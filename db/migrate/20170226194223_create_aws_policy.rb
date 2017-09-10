class CreateAwsPolicy < ActiveRecord::Migration
  def change
    create_table :aws_policies do |t|
      t.references :aws_thing, index: true
      t.string :name
      t.string :arn
      t.string :version_id
      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
