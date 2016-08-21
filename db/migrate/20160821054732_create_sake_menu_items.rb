class CreateSakeMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :sake_menu_items do |t|
      t.references :festival, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.references :sake, foreign_key: true

      t.timestamps
    end
  end
end
