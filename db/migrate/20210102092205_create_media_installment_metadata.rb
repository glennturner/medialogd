class CreateMediaInstallmentMetadata < ActiveRecord::Migration[6.1]
  def change
    create_table :media_installment_metadata do |t|
      t.integer "media_installment_id", null: false
      t.string "display_name"
      t.text "description"
      t.datetime "released_at"
      t.integer "external_id"
      t.jsonb "images"
      t.jsonb "additional_ids"
      t.index ["media_installment_id"], name: "index_media_installment_metadata_on_media_installment_id"

      t.timestamps
    end

    add_foreign_key :media_installment_metadata, :media_installments
  end
end
