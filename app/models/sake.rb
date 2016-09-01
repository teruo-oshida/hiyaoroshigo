class Sake < ApplicationRecord
  belongs_to :brewery
  has_many :sake_menu_items
  has_many :drinkings
end
