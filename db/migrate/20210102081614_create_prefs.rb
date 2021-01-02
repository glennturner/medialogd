class CreatePrefs < ActiveRecord::Migration[6.1]
  def change
    create_table :prefs do |t|
      t.string "name", null: false
      t.string "value", null: false
      t.string "slug", null: false
      t.boolean "is_public", default: false
      t.index ["name"], name: "index_prefs_on_name", unique: true
      t.index ["slug"], name: "index_prefs_on_slug", unique: true

      t.timestamps
    end
  end
end
