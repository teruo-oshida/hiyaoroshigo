class CreateDrinkings < ActiveRecord::Migration[5.0]
  def change
    create_table :drinkings do |t|
      t.references :festival, foreign_key: true
      t.references :drinker, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.references :sake, foreign_key: true
      t.references :sake_temperature, foreign_key: true

      t.timestamps
    end
  end
end
