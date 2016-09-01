class Drinking < ApplicationRecord
  belongs_to :festival
  belongs_to :drinker
  belongs_to :restaurant
  belongs_to :sake
  belongs_to :sake_temperature
  has_one :vote
end
