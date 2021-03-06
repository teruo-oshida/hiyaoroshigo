class Sake < ApplicationRecord
  belongs_to :brewery
  has_many :sake_menu_items
  has_many :drinkings
  has_many :votes, through: :drinkings

  has_attached_file :photo, styles: { medium: "500x500", thumb: "150x150#" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def voted?(drinker)
    drinkings.exists?(drinker: drinker)
  end
end
