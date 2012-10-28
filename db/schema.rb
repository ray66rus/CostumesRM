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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121028221850) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.string   "contact"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "clients", ["name"], :name => "index_clients_on_name", :unique => true

  create_table "costumes", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "costume_type"
    t.string   "availability"
    t.text     "comment"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "costumes_orders", :id => false, :force => true do |t|
    t.integer "costume_id"
    t.integer "order_id"
  end

  create_table "costumes_parts", :id => false, :force => true do |t|
    t.integer "costume_id"
    t.integer "part_id"
  end

  create_table "orders", :force => true do |t|
    t.integer  "price"
    t.string   "payed_status"
    t.string   "activity_status"
    t.datetime "take_time"
    t.datetime "planed_return_time"
    t.datetime "real_return_time"
    t.integer  "user_id"
    t.integer  "client_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "comment"
  end

  create_table "parts", :force => true do |t|
    t.string   "name"
    t.string   "place"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pictures", :force => true do |t|
    t.integer  "pictureable_id"
    t.string   "pictureable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
