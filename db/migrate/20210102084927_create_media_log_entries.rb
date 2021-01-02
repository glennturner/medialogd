class CreateMediaLogEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :media_log_entries do |t|
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
      t.index ["is_abandoned", "user_id"], name: "index_ledger_entries_on_is_abandoned_and_user_id"
      t.index ["is_completed", "user_id"], name: "index_ledger_entries_on_is_completed_and_user_id"
      t.index ["media_id", "media_group_id", "media_installment_id"], name: "unique_media_entry_idx", unique: true
      t.index ["media_id", "media_installment_id", "user_id"], name: "idx_user_media_installments", unique: true
      t.index ["media_id", "user_id"], name: "index_ledger_entries_on_media_id_and_user_id"
      t.index ["rating", "user_id"], name: "index_ledger_entries_on_rating_and_user_id"

      t.timestamps
    end

    add_foreign_key :media_log_entries, :medias
    add_foreign_key :media_log_entries, :media_installments
    add_foreign_key :media_log_entries, :media_groups
    add_foreign_key :media_log_entries, :users
  end
end
