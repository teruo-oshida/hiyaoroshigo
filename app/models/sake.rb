class Sake < ApplicationRecord
  belongs_to :brewery
  has_many :sake_menu_items
  has_many :drinkings
  has_many :votes, through: :drinkings

  has_attached_file :photo, styles: { medium: "588x412#", thumb: "150x150#" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def voted?(drinker)
    drinkings.exists?(drinker: drinker)
  end

  def self.winner
    sake_id, sum_score =
      Drinking.limit(1).group(:sake_id).joins(:vote).
      order("sum_score DESC").sum(:score).first
    find(sake_id)
  end
end
