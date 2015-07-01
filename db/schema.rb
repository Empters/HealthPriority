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

ActiveRecord::Schema.define(version: 20150701201016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.integer  "parent_id"
    t.string   "name",                              null: false
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "active",             default: true, null: false
    t.integer  "sort_order",         default: 0
    t.string   "meta_keyword"
    t.string   "meta_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "countries", force: true do |t|
    t.string "iso"
    t.string "name"
  end

  create_table "genders", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", force: true do |t|
    t.string   "name",                           null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.integer  "sort_order",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_histories", force: true do |t|
    t.integer  "order_id"
    t.integer  "order_status_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_products", force: true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.string   "name"
    t.integer  "quantity"
    t.decimal  "price"
    t.decimal  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.string   "first_name",                           null: false
    t.string   "last_name",                            null: false
    t.integer  "gender_id",                            null: false
    t.integer  "country_id",                           null: false
    t.integer  "state_id"
    t.string   "address",                              null: false
    t.string   "second_address"
    t.string   "city"
    t.string   "postal_code"
    t.string   "email",                                null: false
    t.string   "phone",                                null: false
    t.string   "fax"
    t.string   "invoice"
    t.integer  "order_status_id",        default: 1,   null: false
    t.decimal  "total"
    t.string   "description"
    t.string   "currency",               default: "£", null: false
    t.string   "ip"
    t.string   "payment_method",                       null: false
    t.string   "payment_status"
    t.date     "payment_date"
    t.integer  "payment_transaction_id"
    t.string   "payer_id"
    t.string   "payer_first_name"
    t.string   "payer_last_name"
    t.string   "payer_country"
    t.string   "payer_state"
    t.string   "payer_address"
    t.string   "payer_second_address"
    t.string   "payer_city"
    t.string   "payer_postal_code"
    t.string   "payer_email"
    t.string   "payer_phone"
    t.string   "payer_fax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["invoice"], name: "index_orders_on_invoice", unique: true, using: :btree

  create_table "product_discounts", force: true do |t|
    t.integer  "product_id",        null: false
    t.integer  "customer_group_id"
    t.integer  "quantity",          null: false
    t.integer  "priority"
    t.decimal  "price",             null: false
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_images", force: true do |t|
    t.integer  "product_id",                     null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "sort_order",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_related", id: false, force: true do |t|
    t.integer "product_id", null: false
    t.integer "related_id", null: false
  end

  create_table "product_reviews", force: true do |t|
    t.integer  "product_id",  null: false
    t.integer  "customer_id"
    t.string   "author"
    t.string   "text",        null: false
    t.integer  "rating"
    t.integer  "status",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip"
  end

  create_table "products", force: true do |t|
    t.string   "name",                               null: false
    t.string   "full_name"
    t.decimal  "price",              default: 0.0,   null: false
    t.integer  "quantity",           default: 0,     null: false
    t.integer  "manufacturer_id",                    null: false
    t.integer  "stock_status_id",    default: 1,     null: false
    t.text     "ingredients"
    t.text     "benefits"
    t.text     "description"
    t.text     "direction"
    t.text     "questions_answers"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "viewed"
    t.integer  "points"
    t.boolean  "active",             default: true,  null: false
    t.integer  "sort_order",         default: 0,     null: false
    t.date     "date_available"
    t.string   "meta_keyword"
    t.string   "meta_description"
    t.boolean  "is_best_seller",     default: false
    t.boolean  "is_spacial_offer",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products_categories", id: false, force: true do |t|
    t.integer "product_id"
    t.integer "category_id"
  end

  create_table "states", force: true do |t|
    t.string  "name"
    t.integer "country_id"
    t.string  "iso"
  end

  create_table "stock_statuses", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "gender_id",                           null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "country_id",                          null: false
    t.integer  "state_id"
    t.string   "city"
    t.string   "postal_code"
    t.string   "address"
    t.string   "second_address"
    t.string   "phone"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "web_store_details", force: true do |t|
    t.text     "contact"
    t.text     "delivery"
    t.text     "faq"
    t.text     "about_us"
    t.text     "partners"
    t.text     "payment_methods"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "rights_and_obligations"
    t.text     "license"
  end

end
