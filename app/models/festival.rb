class Festival < ApplicationRecord
  has_many :sake_menu_items
  has_many :drinkings
end
