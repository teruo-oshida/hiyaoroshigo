class SakeTemperature < ApplicationRecord
  has_many :drinkings
  scope :enabled, -> { where(enabled: true).order("position") }
end
