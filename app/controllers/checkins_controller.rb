class CheckinsController < ApplicationController
  before_action :authenticate_drinker!

  def new
    @checkin = Checkin.new
    @restaurants = Restaurant.order("id")
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
