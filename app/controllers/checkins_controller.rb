class CheckinsController < ApplicationController
   before_action :authenticate_drinker!

  def new
    @checkin = Checkin.new
    @restaurants = Restaurant.all
  end

  def create
    restaurant_id = params[:restaurant][:id]
    user_id = current_drinker.id
    Checkin.create(restaurant_id: restaurant_id, drinker_id: user_id)
    redirect_to restaurant_path(restaurant_id)
  end

end
