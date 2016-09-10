class Drinker < ApplicationRecord
  has_many :drinkings
  has_one :ticket
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  # TODO: パスフレーズを受け取ってticketレコードを紐付ける処理を追加する
  def self.find_for_facebook_oauth(auth,params)
    drinker = Drinker.where(provider: auth.provider, uid: auth.uid).first

    unless drinker
      if Ticket.find_by(params[:passcode]).used?
        drinker = Drinker.new(name:     auth.extra.raw_info.name,
                              provider: auth.provider,                               
                              uid:      auth.uid,
                              email:    auth.info.email,
                              token:    auth.credentials.token,
                              password: Devise.friendly_token)
        drinker.build_ticket
        drinker.save
        # TODO: エラー処理を追加する
      end
    end

    drinker
  end
end
