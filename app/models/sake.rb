class Sake < ApplicationRecord
  belongs_to :brewery
  has_many :sake_menu_items
  has_many :drinkings
  has_many :votes, through: :drinkings

  def voted?(drinker)
    drinkings.exists?(drinker: drinker)
  end
end
