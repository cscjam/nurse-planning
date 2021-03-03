# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_19_161311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cares", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.string "icon"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "journeys", force: :cascade do |t|
    t.bigint "start_user_id"
    t.bigint "start_patient_id"
    t.bigint "end_user_id"
    t.bigint "end_patient_id"
    t.integer "locomotion"
    t.integer "distance", default: 0
    t.integer "duration", default: 0
    t.boolean "is_done", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "lines_json", default: ""
    t.index ["end_patient_id"], name: "index_journeys_on_end_patient_id"
    t.index ["end_user_id"], name: "index_journeys_on_end_user_id"
    t.index ["start_patient_id"], name: "index_journeys_on_start_patient_id"
    t.index ["start_user_id"], name: "index_journeys_on_start_user_id"
  end

  create_table "minutes", force: :cascade do |t|
    t.text "content"
    t.bigint "visit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["visit_id"], name: "index_minutes_on_visit_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "compl_address"
    t.string "phone"
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["team_id"], name: "index_patients_on_team_id"
  end

  create_table "prescription_cares", force: :cascade do |t|
    t.bigint "prescription_id", null: false
    t.bigint "care_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["care_id"], name: "index_prescription_cares_on_care_id"
    t.index ["prescription_id"], name: "index_prescription_cares_on_prescription_id"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.string "title"
    t.date "start_at"
    t.date "end_at"
    t.string "schedule"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "patient_id"
    t.boolean "lundi", default: false
    t.boolean "mardi", default: false
    t.boolean "mercredi", default: false
    t.boolean "jeudi", default: false
    t.boolean "vendredi", default: false
    t.boolean "samedi", default: false
    t.boolean "dimanche", default: false
    t.integer "wish_time"
    t.index ["patient_id"], name: "index_prescriptions_on_patient_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.bigint "team_id", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "current_locomotion", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  create_table "visit_cares", force: :cascade do |t|
    t.bigint "visit_id", null: false
    t.bigint "care_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["care_id"], name: "index_visit_cares_on_care_id"
    t.index ["visit_id"], name: "index_visit_cares_on_visit_id"
  end

  create_table "visits", force: :cascade do |t|
    t.date "date"
    t.integer "position"
    t.time "time"
    t.bigint "user_id", null: false
    t.boolean "is_done"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "wish_time"
    t.bigint "prescription_id"
    t.index ["prescription_id"], name: "index_visits_on_prescription_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "journeys", "patients", column: "end_patient_id"
  add_foreign_key "journeys", "patients", column: "start_patient_id"
  add_foreign_key "journeys", "users", column: "end_user_id"
  add_foreign_key "journeys", "users", column: "start_user_id"
  add_foreign_key "minutes", "visits"
  add_foreign_key "patients", "teams"
  add_foreign_key "prescription_cares", "cares"
  add_foreign_key "prescription_cares", "prescriptions"
  add_foreign_key "prescriptions", "patients"
  add_foreign_key "users", "teams"
  add_foreign_key "visit_cares", "cares"
  add_foreign_key "visit_cares", "visits"
  add_foreign_key "visits", "prescriptions"
  add_foreign_key "visits", "users"
end
