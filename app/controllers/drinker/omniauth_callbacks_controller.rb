class Drinker::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @drinker = Drinker.find_for_facebook_oauth(request.env["omniauth.auth"])
    
    if @drinker.persisted?
      redirect_to "/restaurants/"
    else
     logger.debug("failed!!")
     # session["devise.facebook_data"] = request.env["omniauth.auth"]
     # redirect_to new_drinker_registration_url
    end    
  end
end
