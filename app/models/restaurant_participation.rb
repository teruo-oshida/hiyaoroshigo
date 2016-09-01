class RestaurantParticipation < ApplicationRecord
  belongs_to :festival
  belongs_to :restaurant
end
