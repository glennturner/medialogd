class CreateMediaTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :media_types do |t|
      t.string "display_name", null: false
      t.string "slug", null: false
      t.string "description"
      t.string "resource_name", null: false
      t.boolean "is_public", default: true
      t.boolean "is_active", default: false
      t.index ["display_name"], name: "index_media_types_on_display_name", unique: true
      t.index ["resource_name"], name: "index_media_types_on_resource_name", unique: true
      t.index ["slug"], name: "index_media_types_on_slug", unique: true

      t.timestamps
    end
  end
end
