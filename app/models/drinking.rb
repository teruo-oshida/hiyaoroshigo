class Drinking < ApplicationRecord
  belongs_to :drinker
  belongs_to :festival
  belongs_to :restaurant
  belongs_to :sake
  belongs_to :sake_temperature
  has_one :vote
  accepts_nested_attributes_for :vote
end
