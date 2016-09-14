class FestivalsController < ApplicationController
  skip_before_action :check_current_festival_started, only: [:comingsoon]

  def comingsoon
    if current_festival.started?
      redirect_to "/login"
    else
      reset_session
    end
  end

  def itstoolate
  end

  def thewinner
    if current_festival.ended?
      sakes  = Sake.all
      sake = sakes.max do |sake|
        sake.drinkings.sum { |drinking| drinking&.vote&.score.to_i }
      end
      @sake = sake
    else
      @sake = nil
    end
  end
end
