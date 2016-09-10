class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenricate_user!
    session[:user_return_to] = env['PATH_INFO']
    redirect_to user_omniauth_authorize_patu(:facebook) unless user_signed_in?
  end
end
