class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def map
    @restaurants = Restaurant.all
    @markers = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
#      marker.infoWindow "テスト"
      marker.json({title: restaurant.name})
    end
  end
end
