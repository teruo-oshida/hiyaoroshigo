class Drinker < ApplicationRecord
  has_many :drinkings
  has_many :checkins
  has_one :ticket

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # TODO: パスフレーズを受け取ってticketレコードを紐付ける処理を追加する
  def self.find_for_facebook_oauth(auth,params)
    drinker = Drinker.where(provider: auth.provider, uid: auth.uid).first
    status = false
    status = true if drinker
    unless drinker
      ticket = Ticket.find_by(passcode: params["passcode"])
      if Ticket.find_by(passcode: params["passcode"]).present?
        unless ticket.used?
          ticket.build_drinker(full_name:     auth.extra.raw_info.name,
                               provider: auth.provider,
                               uid:      auth.uid,
                               email:    auth.info.email,
                               token:    auth.credentials.token,
                               password: Devise.friendly_token)
          ticket.save!
          status = true
          drinker = ticket.drinker
        end
      end
    end
    {status: status, drinker: drinker}
  end

  def checked_in?
    Checkin.exists?(:drinker_id => self.id)
  end

  def latest_checkin
    checkins.order("created_at DESC").first
  end

  def checked_in_restaurant_id
    latest_checkin&.restaurant_id
  end
end
