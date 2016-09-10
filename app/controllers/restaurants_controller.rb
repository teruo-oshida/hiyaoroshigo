class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show]
  before_action :authenticate_drinker!, only: [:show]

  def index
    @restaurants = Restaurant.all
  end

  def show
  end

  def map
    @restaurants = Restaurant.all
    @markers = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.picture({
        url: "/assets/sake.png",
        width: 32,
        height: 32
      })
      max = restaurant.tickets.count
      current = 
        restaurant.checkins.where("created_at > ?", 60.minutes.ago).count
      marker.infowindow "#{restaurant.name} (#{current}/#{max})"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name)
    end
end
