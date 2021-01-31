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

ActiveRecord::Schema.define(version: 20171207041223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "estimate_foods", force: :cascade do |t|
    t.bigint "food_type_id"
    t.bigint "estimate_id"
    t.bigint "meal_id"
    t.float "quantity", default: 1.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estimate_id"], name: "index_estimate_foods_on_estimate_id"
    t.index ["food_type_id"], name: "index_estimate_foods_on_food_type_id"
    t.index ["meal_id"], name: "index_estimate_foods_on_meal_id"
  end

  create_table "estimates", force: :cascade do |t|
    t.bigint "user_id"
    t.float "weight"
    t.float "body_fat", default: 0.0
    t.float "activity"
    t.integer "variation", default: 0
    t.integer "tdee"
    t.integer "suggested"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "fats"
    t.float "carbs"
    t.float "proteins"
    t.index ["user_id"], name: "index_estimates_on_user_id"
  end

  create_table "food_groups", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_types", force: :cascade do |t|
    t.string "name"
    t.float "kcal"
    t.float "proteins"
    t.float "carbs"
    t.float "fats"
    t.bigint "food_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_group_id"], name: "index_food_types_on_food_group_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.float "quantity"
    t.string "home_quantity"
    t.bigint "food_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_type_id"], name: "index_foods_on_food_type_id"
  end

  create_table "meals", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.time "hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_meals_on_user_id"
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "sex"
    t.float "height"
    t.date "birth_date"
    t.boolean "approved", default: false, null: false
    t.boolean "admin", default: false
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "estimate_foods", "estimates"
  add_foreign_key "estimate_foods", "food_types"
  add_foreign_key "estimate_foods", "meals"
  add_foreign_key "estimates", "users"
  add_foreign_key "food_types", "food_groups"
  add_foreign_key "foods", "food_types"
  add_foreign_key "meals", "users"
end
