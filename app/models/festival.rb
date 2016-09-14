class Festival < ApplicationRecord
  has_many :drinkings
  has_many :restaurant_participations
  has_many :restaurants, through: :restaurant_participations
  has_many :sake_menu_items

  scope :current, lambda {
    now = Time.current
    where('start_at <= ? AND ? <= end_at', now, now)
  }
  
  def started?
    Time.current >= start_at
  end
  
  def ended?
    Time.current >= end_at
  end
  
  def votable?
    started? && !ended?
  end

  def winner
    sake_id, = drinkings.limit(1).group(:sake_id).joins(:vote).
      order("sum_score DESC").sum(:score).first
    Sake.find(sake_id)
  end
end
