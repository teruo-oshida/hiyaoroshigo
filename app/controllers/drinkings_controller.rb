class DrinkingsController < ApplicationController
  before_action :authenticate_drinker!
  before_action :check_current_festival_not_ended
  before_action :set_drinking, only: %i(show destroy)

  def new
    @drinking = Drinking.new
    @drinking.build_vote

    @restaurant_id = params[:restaurant_id]
    @sake_id       = params[:sake_id]
    @temperatures  = SakeTemperature.enabled
  end

  def create
    drinking = Drinking.new(drinking_params.merge(drinker: current_drinker,
                                                  festival: current_festival))
    drinking.save!

    @restaurant = drinking.restaurant
    @drinkings = get_drinkings(@restaurant)
  end

  def show
  end

  def destroy
    @drinking.destroy!

    @restaurant = @drinking.restaurant
    @drinkings = get_drinkings(@restaurant)
  end

  private

  def set_drinking
    @drinking = current_drinker.drinkings.find(params[:id])
  end

  def get_drinkings(restaurant)
    Drinking.where(drinker:    current_drinker,
                   festival:   current_festival,
                   restaurant: restaurant,
                   sake:       restaurant.sakes)
  end

  def drinking_params
    params.require(:drinking)
          .permit(:restaurant_id, :sake_id, :sake_temperature_id,
                  vote_attributes: :score)
  end
end
