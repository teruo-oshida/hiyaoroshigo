class CreateSakes < ActiveRecord::Migration[5.0]
  def change
    create_table :sakes do |t|
      t.string :name
      t.references :brewery, foreign_key: true

      t.timestamps
    end
  end
end
