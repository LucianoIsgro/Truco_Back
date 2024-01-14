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

ActiveRecord::Schema[7.0].define(version: 2023_12_17_002310) do
  create_table "cards", force: :cascade do |t|
    t.integer "numero"
    t.integer "pinta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards_games", id: false, force: :cascade do |t|
    t.integer "card_id"
    t.integer "game_id"
    t.index ["card_id"], name: "index_cards_games_on_card_id"
    t.index ["game_id"], name: "index_cards_games_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "nombre"
    t.string "token"
    t.integer "estado", default: 0
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_games_on_player_id"
  end

  create_table "player_cards", force: :cascade do |t|
    t.boolean "dropped", default: false
    t.integer "order"
    t.integer "player_id"
    t.integer "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_player_cards_on_card_id"
    t.index ["player_id"], name: "index_player_cards_on_player_id"
  end

  create_table "player_games", force: :cascade do |t|
    t.integer "game_id"
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_player_games_on_game_id"
    t.index ["player_id"], name: "index_player_games_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "players"
  add_foreign_key "player_cards", "cards"
  add_foreign_key "player_cards", "players"
  add_foreign_key "player_games", "games"
  add_foreign_key "player_games", "players"
end
