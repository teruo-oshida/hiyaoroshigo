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
    if self.present?
      return self.drinker_id.nil?
    else
      return false
    end
  end

  private
  
  def set_passcode
    self.passcode ||= SecureRandom.hex(3)
  end
end
