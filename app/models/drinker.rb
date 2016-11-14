class Drinker < ApplicationRecord
  has_many :drinkings
  has_many :checkins
  has_one :ticket

  def self.find_for_facebook_oauth(auth,params)
    drinker = Drinker.where(provider: auth.provider, uid: auth.uid).first
    return { status: true, drinker: drinker } if drinker
    if auth.info.email.blank?
      return { status: false, error: "メールアドレスが取得できませんでした。スタッフにお問い合わせください" }
    end
    ticket = Ticket.find_by(passcode: params["passcode"])
    return { status: false, error: "存在しないパスコードです" } if ticket.blank?
    return { status: false, error: "既に使われているパスコードです" } if ticket.used?
    ticket.build_drinker(full_name: auth.extra.raw_info.name,
                         provider:  auth.provider,
                         uid:       auth.uid,
                         email:     auth.info.email,
                         token:     auth.credentials.token,
                         password:  Devise.friendly_token)
    ticket.save!
    { status: true, drinker: ticket.drinker }
  end

  def checked_in?
    Checkin.exists?(["drinker_id = ? and created_at >= ?",
                     self.id, 30.minutes.ago])
  end

  def latest_checkin
    checkins.order("created_at DESC").first
  end

  def checked_in_restaurant_id
    latest_checkin&.restaurant_id
  end

  def sake_title
    drinks = drinkings.order(:created_at).pluck(:created_at)
    case drinks.size
    when 0...5  then '酒勇者見習い'
    when 5...8  then '日本酒初級戦士'
    when 8...10 then '山陰酒武闘家'
    else gentle_pace?(drinks) ? '伝説の酒勇者' : '呑み過ぎ遊び人'
    end
  end

  private

  def gentle_pace?(drinked_ats)
    froms = drinked_ats[0..-2]
    tos   = drinked_ats[1..-1]
    interval = 15 <= drinked_ats.size ? 5.minutes : 10.minutes
    froms.zip(tos).all? { |from, to| interval <= (to - from) }
  end
end
