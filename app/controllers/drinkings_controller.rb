class DrinkingsController < ApplicationController
  before_action :authenticate_drinker!
  before_action :check_current_festival_not_ended
  before_action :set_drinking, only: %i(show destroy)

  def new
    @drinking = Drinking.new
    @drinking.build_vote

    @festival_id   = Festival.current&.take&.id
    @restaurant_id = params[:restaurant_id]
    @sake_id       = params[:sake_id]
    @temperatures  = SakeTemperature.enabled
  end

  def create
    drinking = Drinking.new(drinking_params.merge(drinker: current_drinker))
    drinking.save!

    @restaurant = drinking.restaurant
    @drinkings  = Drinking.where(drinker:    current_drinker,
                                 restaurant: @restaurant,
                                 sake:       @restaurant.sakes)
  end

  def show
  end

  def destroy
    @drinking.destroy!

    @restaurant = @drinking.restaurant
    @drinkings  = Drinking.where(drinker:    current_drinker,
                                 restaurant: @restaurant,
                                 sake:       @restaurant.sakes)
  end

  private

  def set_drinking
    @drinking = Drinking.find(params[:id])
  end

  def drinking_params
    params.require(:drinking)
          .permit(:festival_id, :restaurant_id, :sake_id, :sake_temperature_id,
                  vote_attributes: :score)
  end
end
