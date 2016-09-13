class Restaurant < ApplicationRecord
  has_many :restaurant_participations
  has_many :festivals, through: :restaurant_participations
  has_many :sake_menu_items
  has_many :sakes, through: :sake_menu_items
  has_many :drinkings
  has_many :checkins
  has_many :tickets
  has_attached_file :icon
  validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/
  validates :congestion_degree, numericality: {
    only_integer: true,
    greater_than: 0,
    less_than: 4
  }, allow_blank: true

  CONGESTION_DEGREES = [1, 2, 3]

  def current_congestion_degree
    if congestion_degree.present? && updated_at > 60.minutes.ago
      congestion_degree
    else
      f = recent_checkin_count.to_f / capacity
      if f < 0.5
        1
      elsif f < 0.8
        2
      else
        3
      end
    end
  end

  def recent_checkin_count
    checkins.where("created_at > ?", 60.minutes.ago).
      count("DISTINCT drinker_id")
  end

  CONGESTION_LABELS = {
    1 => "お席に余裕あり",
    2 => "賑わっています",
    3 => "空席わずかです"
  }
  
  def congestion_label
    CONGESTION_LABELS[current_congestion_degree]
  end
end
