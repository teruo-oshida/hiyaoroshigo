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
    @sake = current_festival.winner
  end
end
