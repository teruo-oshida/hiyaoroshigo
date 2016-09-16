class CheckinsController < ApplicationController
  before_action :authenticate_drinker!
  before_action :check_current_festival_not_ended

  def new
    @checkin = Checkin.new
    @checkin.restaurant = current_drinker.latest_checkin&.restaurant
    @restaurants = current_festival.restaurants.order("id")
  end

  def create
    checkin = Checkin.create(checkin_params.merge(drinker: current_drinker))
    redirect_to restaurant_path(checkin.restaurant)
  end

  private

  def checkin_params
    params.require(:checkin).permit(:restaurant_id)
  end
end
