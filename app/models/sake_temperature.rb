class SakeTemperature < ApplicationRecord
  has_many :drinkings
  scope :enabled, -> { where(enabled: true).order("position") }

  DEFAULT_ID = 3

  def default?
    id == DEFAULT_ID
  end
end
