# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170226194223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aws_certificates", force: :cascade do |t|
    t.integer  "aws_thing_id"
    t.string   "certificate_id"
    t.string   "arn"
    t.string   "pem"
    t.string   "public_key"
    t.string   "private_key"
    t.datetime "deleted_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "aws_certificates", ["aws_thing_id"], name: "index_aws_certificates_on_aws_thing_id", using: :btree
  add_index "aws_certificates", ["deleted_at"], name: "index_aws_certificates_on_deleted_at", using: :btree

  create_table "aws_policies", force: :cascade do |t|
    t.integer  "aws_thing_id"
    t.string   "name"
    t.string   "arn"
    t.string   "version_id"
    t.datetime "deleted_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "aws_policies", ["aws_thing_id"], name: "index_aws_policies_on_aws_thing_id", using: :btree
  add_index "aws_policies", ["deleted_at"], name: "index_aws_policies_on_deleted_at", using: :btree

  create_table "aws_things", force: :cascade do |t|
    t.integer  "device_id"
    t.string   "name"
    t.string   "arn"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "aws_things", ["deleted_at"], name: "index_aws_things_on_deleted_at", using: :btree
  add_index "aws_things", ["device_id"], name: "index_aws_things_on_device_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "serial_number"
    t.string   "status"
    t.string   "owner_status"
    t.integer  "network_id"
    t.datetime "deleted_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "devices", ["deleted_at"], name: "index_devices_on_deleted_at", using: :btree
  add_index "devices", ["network_id"], name: "index_devices_on_network_id", using: :btree

  create_table "devices_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "device_id"
    t.datetime "deleted_at"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "devices_users", ["deleted_at"], name: "index_devices_users_on_deleted_at", using: :btree
  add_index "devices_users", ["device_id"], name: "index_devices_users_on_device_id", using: :btree
  add_index "devices_users", ["user_id"], name: "index_devices_users_on_user_id", using: :btree

  create_table "networks", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "password"
    t.string   "slug"
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "networks", ["deleted_at"], name: "index_networks_on_deleted_at", using: :btree
  add_index "networks", ["user_id"], name: "index_networks_on_user_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.string   "controller"
    t.string   "action"
    t.string   "status"
    t.string   "category"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "permissions", ["deleted_at"], name: "index_permissions_on_deleted_at", using: :btree

  create_table "permissions_roles", id: false, force: :cascade do |t|
    t.integer "permission_id"
    t.integer "role_id"
  end

  add_index "permissions_roles", ["permission_id"], name: "index_permissions_roles_on_permission_id", using: :btree
  add_index "permissions_roles", ["role_id"], name: "index_permissions_roles_on_role_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "label"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles", ["deleted_at"], name: "index_roles_on_deleted_at", using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id", using: :btree
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "provider"
    t.string   "slug"
    t.string   "oauth_token"
    t.string   "email"
    t.datetime "oauth_expires_at"
    t.datetime "deleted_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
