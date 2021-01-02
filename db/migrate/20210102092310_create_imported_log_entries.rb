class CreateImportedLogEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :imported_log_entries do |t|
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
      t.index ["imported_at", "import_errored_at", "user_id"], name: "idx_imported_ledger_entires_status"
      t.index ["media_log_entry_id"], name: "index_imported_ledger_entries_on_media_log_entry_id"
      t.index ["media_id", "media_group_id", "media_installment_id"], name: "idx_imported_ledger_entries_verified_media"
      t.index ["media_type_id"], name: "index_imported_ledger_entries_on_media_type_id"
      t.index ["user_id", "verified_at"], name: "index_imported_ledger_entries_on_user_id_and_verified_at"
      t.index ["user_id"], name: "index_imported_ledger_entries_on_user_id"

      t.timestamps
    end

    add_foreign_key :imported_log_entries, :medias
    add_foreign_key :imported_log_entries, :media_groups
    add_foreign_key :imported_log_entries, :media_installments
    add_foreign_key :imported_log_entries, :media_log_entries
    add_foreign_key :imported_log_entries, :media_types
    add_foreign_key :imported_log_entries, :users
  end
end
