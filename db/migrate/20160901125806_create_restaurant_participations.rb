class CreateRestaurantParticipations < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_participations do |t|
      t.references :festival, foreign_key: true
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
