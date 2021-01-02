class CreateMediaMetadata < ActiveRecord::Migration[6.1]
  def change
    create_table :media_metadata do |t|
      t.integer "media_id", null: false
      t.integer "external_id"
      t.jsonb "images"
      t.jsonb "additional_ids"
      t.integer "media_installment_id"
      t.index ["external_id"], name: "index_media_metadata_on_external_id"
      t.index ["media_id", "external_id"], name: "index_media_metadata_on_media_id_and_external_id", unique: true
      t.index ["media_id", "media_installment_id"], name: "index_media_metadata_on_media_id_and_media_installment_id", unique: true
      t.index ["media_id"], name: "index_media_metadata_on_media_id"

      t.timestamps
    end

    add_foreign_key :media_metadata, :medias
    add_foreign_key :media_metadata, :media_installments
  end
end
