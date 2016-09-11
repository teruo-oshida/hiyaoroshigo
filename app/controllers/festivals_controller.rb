class FestivalsController < ApplicationController
  def thewinner
    sakes  = Sake.all
    sake = sakes.max do |sake|
      sake.drinkings.sum { |drinking| drinking&.vote&.score.to_i }
    end
    @sake = sake
  end
end
