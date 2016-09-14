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
      sake_id, sum_score =
        Drinking.limit(1).group(:sake_id).joins(:vote).
        order("sum_score DESC").sum(:score).first
      @sake = Sake.find(sake_id)
    else
      @sake = nil
    end
  end
end
