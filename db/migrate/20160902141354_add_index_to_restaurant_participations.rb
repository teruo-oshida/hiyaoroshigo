class AddIndexToRestaurantParticipations < ActiveRecord::Migration[5.0]
  def change
    add_index :restaurant_participations, [:festival_id, :restaurant_id],
     unique: true, name: "unique_index_restaurant_participations"
  end
end
