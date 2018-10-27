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

ActiveRecord::Schema.define(version: 20181021150608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer "student_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_attendances_on_student_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "country_code"
    t.boolean "notify_demand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student_id"
    t.string "line_token"
    t.string "phone2"
    t.string "phone3"
    t.index ["student_id"], name: "index_contacts_on_student_id"
  end

  create_table "course_students", force: :cascade do |t|
    t.integer "course_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_students_on_course_id"
    t.index ["student_id"], name: "index_course_students_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.integer "department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "certificate_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id"
    t.string "color"
    t.index ["course_id"], name: "index_events_on_course_id"
  end

  create_table "homes", force: :cascade do |t|
    t.integer "sort"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "card_id"
    t.string "afts_id"
    t.string "school"
    t.string "grade"
    t.string "identity_code"
    t.datetime "birthday"
    t.string "address"
    t.string "contact_name"
    t.string "contact_phone"
    t.string "contact_phone2"
    t.string "contact_phone3"
    t.string "remark"
  end

  create_table "notifies", force: :cascade do |t|
    t.string "message"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifies_students", id: false, force: :cascade do |t|
    t.integer "notify_id"
    t.integer "student_id"
    t.index ["notify_id"], name: "index_notifies_students_on_notify_id"
    t.index ["student_id"], name: "index_notifies_students_on_student_id"
  end

  create_table "site_homes", force: :cascade do |t|
    t.integer "home_id"
    t.integer "site_id"
    t.index ["home_id"], name: "index_site_homes_on_home_id"
    t.index ["site_id"], name: "index_site_homes_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "afts_id", null: false
    t.string "name"
    t.string "card_id"
    t.string "school"
    t.string "grade"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_id"
    t.datetime "birthday"
    t.string "identity_code"
    t.string "address"
    t.string "remark"
    t.index ["afts_id"], name: "index_students_on_afts_id", unique: true
  end

  create_table "temporary_data", force: :cascade do |t|
    t.text "data"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
