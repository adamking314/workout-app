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

ActiveRecord::Schema[8.0].define(version: 2025_06_06_000026) do
  create_table "saved_workouts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "workout_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "workout_id"], name: "index_saved_workouts_on_user_id_and_workout_id", unique: true
    t.index ["user_id"], name: "index_saved_workouts_on_user_id"
    t.index ["workout_id"], name: "index_saved_workouts_on_workout_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "token"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "workouts", force: :cascade do |t|
    t.string "username", null: false
    t.string "workout_name", null: false
    t.text "description"
    t.string "block_name"
    t.string "exercise"
    t.integer "sets"
    t.integer "reps"
    t.decimal "weight"
    t.decimal "percent_of_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "blocks"
    t.index ["username"], name: "index_workouts_on_username"
  end

  add_foreign_key "saved_workouts", "users"
  add_foreign_key "saved_workouts", "workouts"
  add_foreign_key "sessions", "users"
end
