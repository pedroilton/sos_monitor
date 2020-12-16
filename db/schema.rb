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

ActiveRecord::Schema.define(version: 2020_12_16_165543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_years", force: :cascade do |t|
    t.string "title"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

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

  create_table "class_monitors", force: :cascade do |t|
    t.bigint "university_class_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_class_monitors_on_student_id"
    t.index ["university_class_id"], name: "index_class_monitors_on_university_class_id"
  end

  create_table "classes_students", force: :cascade do |t|
    t.bigint "university_class_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_classes_students_on_student_id"
    t.index ["university_class_id"], name: "index_classes_students_on_university_class_id"
  end

  create_table "disciplines", force: :cascade do |t|
    t.string "title"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: true
  end

  create_table "monitorings", force: :cascade do |t|
    t.bigint "class_monitor_id", null: false
    t.text "question"
    t.string "place"
    t.text "excuse"
    t.datetime "date_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["class_monitor_id"], name: "index_monitorings_on_class_monitor_id"
  end

  create_table "monitorings_students", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "monitoring_id", null: false
    t.integer "rating"
    t.text "review"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["monitoring_id"], name: "index_monitorings_students_on_monitoring_id"
    t.index ["student_id"], name: "index_monitorings_students_on_student_id"
  end

  create_table "university_classes", force: :cascade do |t|
    t.string "title"
    t.bigint "discipline_id", null: false
    t.bigint "professor_id", null: false
    t.bigint "academic_year_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["academic_year_id"], name: "index_university_classes_on_academic_year_id"
    t.index ["discipline_id"], name: "index_university_classes_on_discipline_id"
    t.index ["professor_id"], name: "index_university_classes_on_professor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "nickname"
    t.string "phone_number"
    t.boolean "student", default: false
    t.boolean "professor", default: false
    t.boolean "admin", default: false
    t.string "registration", null: false
    t.boolean "active", default: true
    t.boolean "monitor", default: false
    t.index ["registration"], name: "index_users_on_registration", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "class_monitors", "university_classes"
  add_foreign_key "class_monitors", "users", column: "student_id"
  add_foreign_key "classes_students", "university_classes"
  add_foreign_key "classes_students", "users", column: "student_id"
  add_foreign_key "monitorings", "class_monitors"
  add_foreign_key "monitorings_students", "monitorings"
  add_foreign_key "monitorings_students", "users", column: "student_id"
  add_foreign_key "university_classes", "academic_years"
  add_foreign_key "university_classes", "disciplines"
  add_foreign_key "university_classes", "users", column: "professor_id"
end
