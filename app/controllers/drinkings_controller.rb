class DrinkingsController < ApplicationController
  def new
    @drinking = Drinking.new
    @vote = Vote.new
  end

  def create
    @drinking = Drinking.create(drinking_params)
    @vote = Vote.create(vote_params)
  end

  private
    def drinking_params
      params.require(:drinking).permit()
    end

    def vote_params
      params.reqiore(:vote).permit(:drinking_id, :score)
    end
end
