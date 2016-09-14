require "securerandom"

class Ticket < ApplicationRecord
  belongs_to :drinker
  belongs_to :festival
  belongs_to :restaurant
  after_initialize :set_passcode

  def signup_url
    "https://matsuetranquilo.shimane-oss.org/signup?passcode=" + passcode
  end

  def used?
    !drinker_id.nil?
  end

  private

  def set_passcode
    self.passcode ||= SecureRandom.hex(3)
  end
end
