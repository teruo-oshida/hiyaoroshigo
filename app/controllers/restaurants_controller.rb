class RestaurantsController < ApplicationController
  before_action :authenticate_drinker!
  before_action :check_current_festival_not_ended

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @drinkings  = Drinking.where(drinker:    current_drinker,
                                 restaurant: @restaurant,
                                 sake:       @restaurant.sakes)
    if request.xhr?
      render partial: "detail", locals: { restaurant: @restaurant }
    end
  end

  def vote
    if current_drinker.checked_in?
      redirect_to restaurant_path(current_drinker.latest_checkin.restaurant)
    else
      redirect_to new_checkin_path
    end
  end

  def map
    @restaurants = Restaurant.all
    @restaurant =
      current_drinker.latest_checkin&.restaurant ||
      current_drinker.ticket&.restaurant ||
      Restaurant.first
    @markers = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.picture({
        url: "/assets/marker#{restaurant.current_congestion_degree}.png",
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
