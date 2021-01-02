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

ActiveRecord::Schema.define(version: 2021_01_02_153048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "imported_log_entries", force: :cascade do |t|
    t.integer "media_id"
    t.integer "media_group_id"
    t.integer "media_installment_id"
    t.integer "media_log_entry_id"
    t.integer "media_type_id", null: false
    t.integer "user_id", null: false
    t.datetime "imported_at", null: false
    t.datetime "verified_at"
    t.datetime "import_errored_at"
    t.text "error_message"
    t.jsonb "ledger_record", default: {}
    t.text "original_record", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["imported_at", "import_errored_at", "user_id"], name: "idx_imported_ledger_entires_status"
    t.index ["media_id", "media_group_id", "media_installment_id"], name: "idx_imported_ledger_entries_verified_media"
    t.index ["media_log_entry_id"], name: "index_imported_ledger_entries_on_media_log_entry_id"
    t.index ["media_type_id"], name: "index_imported_ledger_entries_on_media_type_id"
    t.index ["user_id", "verified_at"], name: "index_imported_ledger_entries_on_user_id_and_verified_at"
    t.index ["user_id"], name: "index_imported_ledger_entries_on_user_id"
  end

  create_table "media_groups", force: :cascade do |t|
    t.text "display_name"
    t.integer "order_num", default: 0
    t.integer "parent_group_id"
    t.datetime "released_at"
    t.integer "media_id"
    t.boolean "is_public", default: false
    t.boolean "is_active", default: false
    t.integer "group_num", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_num", "media_id"], name: "index_media_groups_on_group_num_and_media_id", unique: true
    t.index ["is_public", "is_active"], name: "index_media_groups_on_is_public_and_is_active"
    t.index ["media_id"], name: "index_media_groups_on_media_id"
    t.index ["parent_group_id"], name: "index_media_groups_on_parent_group_id"
  end

  create_table "media_installment_metadata", force: :cascade do |t|
    t.integer "media_installment_id", null: false
    t.string "display_name"
    t.text "description"
    t.datetime "released_at"
    t.integer "external_id"
    t.jsonb "images"
    t.jsonb "additional_ids"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["media_installment_id"], name: "index_media_installment_metadata_on_media_installment_id"
  end

  create_table "media_installments", force: :cascade do |t|
    t.text "display_name"
    t.string "slug", null: false
    t.boolean "is_public", default: true
    t.boolean "is_active", default: true
    t.integer "media_id", null: false
    t.text "description"
    t.datetime "released_at"
    t.datetime "last_metadata_lookup_at"
    t.integer "external_id"
    t.string "type"
    t.integer "installment_num"
    t.integer "media_group_id"
    t.integer "group_installment_num"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["external_id"], name: "index_media_installments_on_external_id"
    t.index ["group_installment_num", "media_group_id"], name: "idx_group_install_nums", unique: true
    t.index ["last_metadata_lookup_at"], name: "index_media_installments_on_last_metadata_lookup_at"
    t.index ["media_id", "media_group_id"], name: "index_media_installments_on_media_id_and_media_group_id"
    t.index ["media_id"], name: "index_media_installments_on_media_id"
    t.index ["slug"], name: "index_media_installments_on_slug", unique: true
    t.index ["type"], name: "index_media_installments_on_type"
  end

  create_table "media_log_entries", force: :cascade do |t|
    t.integer "media_id", null: false
    t.integer "media_installment_id"
    t.integer "user_id", null: false
    t.integer "rating", default: 0
    t.integer "progress", default: 100
    t.datetime "logged_at", null: false
    t.boolean "is_completed", default: true
    t.boolean "is_abandoned", default: false
    t.boolean "is_public", default: true
    t.boolean "is_active", default: false
    t.text "notes"
    t.integer "media_group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["is_abandoned", "user_id"], name: "index_ledger_entries_on_is_abandoned_and_user_id"
    t.index ["is_completed", "user_id"], name: "index_ledger_entries_on_is_completed_and_user_id"
    t.index ["media_id", "media_group_id", "media_installment_id"], name: "unique_media_entry_idx", unique: true
    t.index ["media_id", "media_installment_id", "user_id"], name: "idx_user_media_installments", unique: true
    t.index ["media_id", "user_id"], name: "index_ledger_entries_on_media_id_and_user_id"
    t.index ["rating", "user_id"], name: "index_ledger_entries_on_rating_and_user_id"
  end

  create_table "media_metadata", force: :cascade do |t|
    t.integer "media_id", null: false
    t.integer "external_id"
    t.jsonb "images"
    t.jsonb "additional_ids"
    t.integer "media_installment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["external_id"], name: "index_media_metadata_on_external_id"
    t.index ["media_id", "external_id"], name: "index_media_metadata_on_media_id_and_external_id", unique: true
    t.index ["media_id", "media_installment_id"], name: "index_media_metadata_on_media_id_and_media_installment_id", unique: true
    t.index ["media_id"], name: "index_media_metadata_on_media_id"
  end

  create_table "media_types", force: :cascade do |t|
    t.string "display_name", null: false
    t.string "slug", null: false
    t.string "description"
    t.string "resource_name", null: false
    t.boolean "is_public", default: true
    t.boolean "is_active", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["display_name"], name: "index_media_types_on_display_name", unique: true
    t.index ["resource_name"], name: "index_media_types_on_resource_name", unique: true
    t.index ["slug"], name: "index_media_types_on_slug", unique: true
  end

  create_table "medias", force: :cascade do |t|
    t.string "display_name", null: false
    t.string "slug", null: false
    t.integer "duration"
    t.boolean "is_numerable", default: false
    t.boolean "is_public", default: true
    t.boolean "is_active", default: false
    t.text "description"
    t.datetime "released_at"
    t.datetime "last_metadata_lookup_at"
    t.integer "media_type_id"
    t.integer "external_id"
    t.datetime "last_media_installment_metadata_lookup_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["external_id"], name: "index_medias_on_external_id"
    t.index ["last_metadata_lookup_at"], name: "index_medias_on_last_metadata_lookup_at"
    t.index ["media_type_id"], name: "index_medias_on_media_type_id"
    t.index ["slug"], name: "index_medias_on_slug"
  end

  create_table "prefs", force: :cascade do |t|
    t.string "name", null: false
    t.string "value", null: false
    t.string "slug", null: false
    t.boolean "is_public", default: false
    t.integer "minimum_role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_prefs_on_name", unique: true
    t.index ["slug"], name: "index_prefs_on_slug", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "imported_log_entries", "media_groups"
  add_foreign_key "imported_log_entries", "media_installments"
  add_foreign_key "imported_log_entries", "media_log_entries"
  add_foreign_key "imported_log_entries", "media_types"
  add_foreign_key "imported_log_entries", "medias"
  add_foreign_key "imported_log_entries", "users"
  add_foreign_key "media_groups", "medias"
  add_foreign_key "media_installment_metadata", "media_installments"
  add_foreign_key "media_installments", "media_groups"
  add_foreign_key "media_installments", "medias"
  add_foreign_key "media_log_entries", "media_groups"
  add_foreign_key "media_log_entries", "media_installments"
  add_foreign_key "media_log_entries", "medias"
  add_foreign_key "media_log_entries", "users"
  add_foreign_key "media_metadata", "media_installments"
  add_foreign_key "media_metadata", "medias"
  add_foreign_key "medias", "media_types"
end
