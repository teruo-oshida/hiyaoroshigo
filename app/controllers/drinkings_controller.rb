class DrinkingsController < ApplicationController
  def new
    @drinking = Drinking.new
    @drinking.build_vote

    @festival_id   = Festival.current&.take&.id
    @restaurant_id = params[:restaurant_id]
    @sake_id       = params[:sake_id]
    @temperatures  = SakeTemperature.enabled
  end

  def create
    Drinking.create!(drinking_params.merge(drinker: current_drinker))
  end

  def destroy
  end

  private

  def drinking_params
    params.require(:drinking)
          .permit(:festival_id, :restaurant_id, :sake_id, :sake_temperature_id,
                  vote_attributes: :score)
  end
end
