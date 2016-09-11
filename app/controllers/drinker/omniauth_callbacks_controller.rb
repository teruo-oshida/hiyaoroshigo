class Drinker::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # TODO:
    # request.env['omniauth.params']でパスフレーズを取得して、
    # ↓のfind_for_facebook_oauthに渡してその中で、
    # 紐づくticketレコードを生成してやれば良いかと
    @drinker = Drinker.find_for_facebook_oauth(request.env["omniauth.auth"],request.env['omniauth.params'])

    if @drinker.persisted?
      redirect_by_checkin_status
      sign_in @drinker
    else
     logger.debug("failed!!")
     # session["devise.facebook_data"] = request.env["omniauth.auth"]
     # redirect_to new_drinker_registration_url
    end
  end

  private

  def redirect_by_checkin_status
    if @drinker.checked_in?
      restaurant_id = @drinker.checked_in_restaurant_id
      redirect_to restaurant_path(restaurant_id)
    else
      redirect_to new_checkin_path
    end
  end
end
