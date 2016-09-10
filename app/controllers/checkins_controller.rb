class CheckinsController < ApplicationController
   before_action :authenricate_drinker!

  def new
    @checkin = Checkin.new
    @restaurants = Restaurant.all
  end

  def create
    restaurant_id = params[:restaurant][:id]
    user_id = current_drinker.id
    Checkin.create(restaurant_id: restaurant_id, drinker_id: user_id)
    render text: "#{Restaurant.find(restaurant_id).name}にチェックイン"
  end
end
