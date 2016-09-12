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

  CONGESTION_DEGREES = [1, 2, 3]

  # 混雑度（1〜3）を返す。ランダムな値を返す仮実装。
  def congestion_degree
    CONGESTION_DEGREES.sample
  end

  CONGESTION_LABESL = {
    1 => "お席に余裕あり",
    2 => "（考え中）",
    3 => "ほぼ満席"
  }
  
  def congestion_label
    CONGESTION_LABESL[congestion_degree]
  end
end
