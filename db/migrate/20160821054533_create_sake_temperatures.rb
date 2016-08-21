class CreateSakeTemperatures < ActiveRecord::Migration[5.0]
  def change
    create_table :sake_temperatures do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
