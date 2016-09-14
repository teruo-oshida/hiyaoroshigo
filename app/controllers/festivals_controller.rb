class FestivalsController < ApplicationController
  skip_before_action :check_current_festival_started, only: [:comingsoon]

  def comingsoon
    reset_session
  end

  def thewinner
    sakes  = Sake.all
    sake = sakes.max do |sake|
      sake.drinkings.sum { |drinking| drinking&.vote&.score.to_i }
    end
    @sake = sake
  end
end
