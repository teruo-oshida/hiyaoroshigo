class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def map
    @restaurants = Restaurant.all
    @markers = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      max = restaurant.tickets.count
      current = 
        restaurant.checkins.where("created_at > ?", 60.minutes.ago).count
      marker.infowindow "#{restaurant.name} (#{current}/#{max})"
    end
  end
end
