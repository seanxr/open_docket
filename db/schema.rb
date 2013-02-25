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

ActiveRecord::Schema.define(:version => 20130221133740) do

  create_table "action_item_meetings", :force => true do |t|
    t.integer  "aktion_id"
    t.integer  "item_meeting_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "activities", :force => true do |t|
    t.date     "date_actual"
    t.string   "person_actual"
    t.text     "note"
    t.string   "activity_type"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "message"
  end

  create_table "activity_logs", :force => true do |t|
    t.integer  "activity_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "aktions", :force => true do |t|
    t.text     "discussion"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "meeting_id"
  end

  create_table "attachments", :force => true do |t|
    t.integer  "document_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "committee_meetings", :force => true do |t|
    t.integer  "meeting_id"
    t.integer  "committee_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

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
    t.text     "note"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.date     "as_of"
  end

  add_index "dockets", ["committee_id"], :name => "index_dockets_on_committee_id"
  add_index "dockets", ["item_id", "committee_id"], :name => "index_dockets_on_docket_item_id_and_committee_id", :unique => true
  add_index "dockets", ["item_id"], :name => "index_dockets_on_docket_item_id"

  create_table "documents", :force => true do |t|
    t.string   "doc_type"
    t.string   "name"
    t.string   "description"
    t.string   "submitted_by"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "URL"
    t.date     "submitted_on"
  end

  create_table "item_meetings", :force => true do |t|
    t.integer  "item_id"
    t.integer  "meeting_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "agendable_id"
    t.string   "agendable_type"
    t.integer  "position"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.date     "opened_on"
    t.text     "requested_by"
    t.boolean  "draft"
    t.text     "request"
    t.text     "address"
    t.string   "ward"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "reference"
  end

  add_index "items", ["name"], :name => "index_docket_items_on_number", :unique => true

  create_table "meeting_texts", :force => true do |t|
    t.integer  "meeting_id"
    t.text     "meeting_text"
    t.integer  "action_required"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "meetings", :force => true do |t|
    t.date     "date"
    t.integer  "room_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.string   "floor"
    t.string   "number"
    t.integer  "capacity"
    t.string   "notes"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "site_id"
  end

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

  create_table "statuses", :force => true do |t|
    t.integer  "code"
    t.string   "statused_type"
    t.integer  "statused_id"
    t.integer  "statuser_id"
    t.integer  "creator_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.date     "as_of"
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
