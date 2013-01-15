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

ActiveRecord::Schema.define(:version => 20130115105445) do

  create_table "committees", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "shortname"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "committees", ["name"], :name => "index_committees_on_name", :unique => true

  create_table "dockets", :force => true do |t|
    t.integer  "item_id"
    t.integer  "committee_id"
    t.string   "creator_id"
    t.string   "integer"
    t.string   "updater_id"
    t.text     "note"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "dockets", ["committee_id"], :name => "index_dockets_on_committee_id"
  add_index "dockets", ["item_id", "committee_id"], :name => "index_dockets_on_docket_item_id_and_committee_id", :unique => true
  add_index "dockets", ["item_id"], :name => "index_dockets_on_docket_item_id"

  create_table "items", :force => true do |t|
    t.string   "number"
    t.date     "opened_on"
    t.text     "requested_by"
    t.boolean  "draft"
    t.text     "request"
    t.text     "address"
    t.string   "ward"
    t.string   "precinct"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "reference"
  end

  add_index "items", ["number"], :name => "index_docket_items_on_number", :unique => true

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "postal"
    t.string   "geo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
