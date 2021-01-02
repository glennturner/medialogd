class CreateMediaInstallments < ActiveRecord::Migration[6.1]
  def change
    create_table :media_installments do |t|
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
      t.index ["external_id"], name: "index_media_installments_on_external_id"
      t.index ["group_installment_num", "media_group_id"], name: "idx_group_install_nums", unique: true
      t.index ["last_metadata_lookup_at"], name: "index_media_installments_on_last_metadata_lookup_at"
      t.index ["media_id", "media_group_id"], name: "index_media_installments_on_media_id_and_media_group_id"
      t.index ["media_id"], name: "index_media_installments_on_media_id"
      t.index ["slug"], name: "index_media_installments_on_slug", unique: true
      t.index ["type"], name: "index_media_installments_on_type"

      t.timestamps
    end

    add_foreign_key :media_installments, :medias
    add_foreign_key :media_installments, :media_groups
  end
end
