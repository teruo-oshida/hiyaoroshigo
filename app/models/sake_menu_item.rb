class SakeMenuItem < ApplicationRecord
  belongs_to :festival
  belongs_to :restaurant
  belongs_to :sake
end
