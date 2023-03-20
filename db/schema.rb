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

ActiveRecord::Schema[7.0].define(version: 2023_03_14_132716) do
  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
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

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "carts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_id"
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_carts_on_product_id"
    t.index ["user_id", "product_id"], name: "index_carts_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "communities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "text", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_communities_on_user_id"
  end

  create_table "community_messages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "communityMessage_content"
    t.bigint "user_id"
    t.bigint "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_community_messages_on_community_id"
    t.index ["user_id"], name: "index_community_messages_on_user_id"
  end

  create_table "invitations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_invitations_on_community_id"
    t.index ["user_id", "community_id"], name: "index_invitations_on_user_id_and_community_id", unique: true
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "order_details", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.integer "price", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id", "product_id"], name: "index_order_details_on_order_id_and_product_id", unique: true
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "billing_amount", null: false
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "participations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_participations_on_community_id"
    t.index ["user_id", "community_id"], name: "index_participations_on_user_id_and_community_id", unique: true
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "post_comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "postComment_content"
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_comments_on_post_id"
    t.index ["user_id"], name: "index_post_comments_on_user_id"
  end

  create_table "post_favorites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_favorites_on_post_id"
    t.index ["user_id", "post_id"], name: "index_post_favorites_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_post_favorites_on_user_id"
  end

  create_table "post_unfavorites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_unfavorites_on_post_id"
    t.index ["user_id", "post_id"], name: "index_post_unfavorites_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_post_unfavorites_on_user_id"
  end

  create_table "posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "text", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "product_comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "productComment_content"
    t.bigint "user_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_comments_on_product_id"
    t.index ["user_id"], name: "index_product_comments_on_user_id"
  end

  create_table "product_favorites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_favorites_on_product_id"
    t.index ["user_id", "product_id"], name: "index_product_favorites_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_product_favorites_on_user_id"
  end

  create_table "product_unfavorites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_unfavorites_on_product_id"
    t.index ["user_id", "product_id"], name: "index_product_unfavorites_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_product_unfavorites_on_user_id"
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "text", null: false
    t.string "type", null: false
    t.string "prefecture", null: false
    t.integer "price", null: false
    t.integer "quantity", default: 1, null: false
    t.integer "stock", null: false
    t.boolean "recommend"
    t.boolean "purchased"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "relationships", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "following_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["following_id", "followed_id"], name: "index_relationships_on_following_id_and_followed_id", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "prefecture"
    t.string "zipcode"
    t.string "street"
    t.string "building"
    t.string "text"
    t.string "password_digest", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "refresh_jti"
    t.integer "confirmation_status", default: 1, null: false
    t.string "confirmation_token", limit: 64
    t.datetime "expiration_date"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "carts", "products"
  add_foreign_key "carts", "users"
  add_foreign_key "communities", "users"
  add_foreign_key "community_messages", "communities"
  add_foreign_key "community_messages", "users"
  add_foreign_key "invitations", "communities"
  add_foreign_key "invitations", "users"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "participations", "communities"
  add_foreign_key "participations", "users"
  add_foreign_key "post_comments", "posts"
  add_foreign_key "post_comments", "users"
  add_foreign_key "post_favorites", "posts"
  add_foreign_key "post_favorites", "users"
  add_foreign_key "post_unfavorites", "posts"
  add_foreign_key "post_unfavorites", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "product_comments", "products"
  add_foreign_key "product_comments", "users"
  add_foreign_key "product_favorites", "products"
  add_foreign_key "product_favorites", "users"
  add_foreign_key "product_unfavorites", "products"
  add_foreign_key "product_unfavorites", "users"
  add_foreign_key "products", "users"
end
