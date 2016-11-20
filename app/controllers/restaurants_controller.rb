class RestaurantsController < ApplicationController
  before_action :authenticate_drinker!
  before_action :check_current_festival_not_ended

  def show
    @restaurant = Restaurant.find(params[:id])
    @drinkings  = restaurant_drinkings(@restaurant)
    if request.xhr?
      render partial: "detail", locals: { restaurant: @restaurant }
    end
  end

  def vote
    redirect_to restaurant_path(1)
  end

  def map
    @restaurants = current_festival.restaurants
    @restaurant =
      current_drinker.latest_checkin&.restaurant ||
      current_drinker.ticket&.restaurant ||
      Restaurant.first
    @markers = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.picture({
        url: ActionController::Base.helpers.
          asset_path("marker#{restaurant.current_congestion_degree}.png"),
        width: 42,
        height: 42
      })
      marker.infowindow restaurant.official_name
      marker.title restaurant.id.to_s
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
