class CreateMediaGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :media_groups do |t|
      t.text "display_name"
      t.integer "order_num", default: 0
      t.integer "parent_group_id"
      t.datetime "released_at"
      t.integer "media_id"
      t.boolean "is_public", default: false
      t.boolean "is_active", default: false
      t.integer "group_num", default: 1
      t.index ["group_num", "media_id"], name: "index_media_groups_on_group_num_and_media_id", unique: true
      t.index ["is_public", "is_active"], name: "index_media_groups_on_is_public_and_is_active"
      t.index ["media_id"], name: "index_media_groups_on_media_id"
      t.index ["parent_group_id"], name: "index_media_groups_on_parent_group_id"

      t.timestamps
    end

    add_foreign_key :media_groups, :medias
  end
end
