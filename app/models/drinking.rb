class Drinking < ApplicationRecord
  belongs_to :drinker
  belongs_to :festival
  belongs_to :restaurant
  belongs_to :sake
  belongs_to :sake_temperature
  has_one :vote, dependent: :destroy
  accepts_nested_attributes_for :vote

  # ShimaneCommunities2016に関しては各お酒への投票は一人一回のみ
  validates :drinker_id, uniqueness: { scope: %i(sake_id) }, allow_nil: true
end
