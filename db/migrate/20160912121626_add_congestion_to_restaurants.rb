class AddCongestionToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :congestion_degree, :integer
    add_column :restaurants, :capacity, :integer
  end
end
