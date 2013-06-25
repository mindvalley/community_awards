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

ActiveRecord::Schema.define(:version => 20130625094958) do

  create_table "ballots", :force => true do |t|
    t.integer  "employee_id"
    t.float    "adjustment_factor", :default => 1.0
    t.string   "period"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.text     "schedule"
    t.integer  "value_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "employees", :force => true do |t|
    t.string   "email"
    t.date     "date_joined"
    t.date     "start_date"
    t.boolean  "voteable",        :default => true
    t.string   "team"
    t.string   "status"
    t.string   "nick_name"
    t.string   "full_legal_name"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "results", :force => true do |t|
    t.string   "period"
    t.hstore   "lines"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "results", ["lines"], :name => "index_results_on_lines"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "auth_hash"
    t.string   "provider"
    t.string   "uid"
    t.string   "info"
    t.string   "credentials"
    t.string   "extra"
    t.string   "role",        :default => "employee"
  end

  create_table "values", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "votes", :force => true do |t|
    t.string   "candidate"
    t.float    "points"
    t.integer  "ballot_id"
    t.integer  "employee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "value_id"
  end

end
