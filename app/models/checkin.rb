class Checkin < ApplicationRecord
  belongs_to :drinker
  belongs_to :restaurant
end
