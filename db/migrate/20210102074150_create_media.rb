class CreateMedia < ActiveRecord::Migration[6.1]
  def change
    create_table :medias do |t|
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
      t.index ["external_id"], name: "index_medias_on_external_id"
      t.index ["last_metadata_lookup_at"], name: "index_medias_on_last_metadata_lookup_at"
      t.index ["slug"], name: "index_medias_on_slug"
      t.index ["media_type_id"], name: "index_medias_on_media_type_id"

      t.timestamps
    end

    add_foreign_key :medias, :media_types
  end
end
