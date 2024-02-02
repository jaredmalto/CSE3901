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

ActiveRecord::Schema[7.0].define(version: 2023_12_06_181912) do
  create_table "enrollments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "presentation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["presentation_id"], name: "index_enrollments_on_presentation_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer "presentation_id", null: false
    t.integer "evaluator_id", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_score"
    t.integer "content_score"
    t.integer "visuals_score"
    t.integer "delivery_score"
    t.index ["evaluator_id"], name: "index_evaluations_on_evaluator_id"
    t.index ["presentation_id"], name: "index_evaluations_on_presentation_id"
  end

  create_table "presentations", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "email"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "enrollments", "presentations"
  add_foreign_key "enrollments", "users"
  add_foreign_key "evaluations", "presentations"
  add_foreign_key "evaluations", "users", column: "evaluator_id"
end
