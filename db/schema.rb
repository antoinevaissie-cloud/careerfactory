# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_02_005446) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.text "recruiter_feedback"
    t.text "candidate_feedback"
    t.integer "calendly_booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "recruiter_id"
    t.bigint "candidate_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text "candidate_motivation"
    t.bigint "campaign_id", null: false
    t.index ["campaign_id"], name: "index_bookings_on_campaign_id"
    t.index ["candidate_id"], name: "index_bookings_on_candidate_id"
    t.index ["recruiter_id"], name: "index_bookings_on_recruiter_id"
  end

  create_table "campaign_users", force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaign_users_on_campaign_id"
    t.index ["user_id"], name: "index_campaign_users_on_user_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer "batch_number"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "slot_size"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "company_descriptions"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.integer "batch_number"
    t.string "company"
    t.bigint "company_id"
    t.string "cal_link"
    t.string "cal_api_key"
    t.string "tagline"
    t.string "looking_for"
    t.string "skills"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "campaigns"
  add_foreign_key "bookings", "users", column: "candidate_id"
  add_foreign_key "bookings", "users", column: "recruiter_id"
  add_foreign_key "campaign_users", "campaigns"
  add_foreign_key "campaign_users", "users"
  add_foreign_key "users", "companies"
end
