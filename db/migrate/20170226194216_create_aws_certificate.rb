class CreateAwsCertificate < ActiveRecord::Migration
  def change
    create_table :aws_certificates do |t|
      t.references :aws_thing, index: true
      t.string :certificate_id
      t.string :arn
      t.string :pem
      t.string :public_key
      t.string :private_key
      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
