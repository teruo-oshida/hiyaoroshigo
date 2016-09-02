class Ticket < ApplicationRecord
  belongs_to :drinker
  belongs_to :festival
  belongs_to :restaurant
end
