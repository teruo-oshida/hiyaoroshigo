class AddIndexSakeMenuItems < ActiveRecord::Migration[5.0]
  def change
    add_index :sake_menu_items, [:festival_id, :restaurant_id, :sake_id],
     unique: true, name: "unique_index_sake_menu_items"
  end
end
