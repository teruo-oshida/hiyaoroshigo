class DrinkingsController < ApplicationController
  def index
    @drinking = Drinking.new
    @vote = Vote.new
  end

  def new
    @drinking = Drinking.create(sake_id: params[:sake_id], drinker_id: current_drinker.id)
    @vote = Vote.create(drinking_id: @drinking.id, score: 0)
  end

  def create
   # @drinking = Drinking.create(drinking_params)
    @vote = Vote.create(vote_params)
  end

  def show
  end

  private
    def drinking_params
      params.require(:drinking).permit(:sake_id)
    end

    def vote_params
      params.require(:vote).permit(:drinking_id, :score)
    end
end
