class CheckinsController < ApplicationController
  def new
    @checkin = Checkin.new
    @restaurants = Restaurant.all
  end

  def create
    render text: "#{Restaurant.find(params[:restaurant_id]).name}にチェックイン"
  end
end
