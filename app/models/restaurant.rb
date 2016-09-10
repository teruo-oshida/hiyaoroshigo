class Restaurant < ApplicationRecord
  has_many :restaurant_participations
  has_many :festivals, through: :restaurant_participations
  has_many :sake_menu_items
  has_many :drinkings
  has_many :checkins
  has_many :tickets
end
