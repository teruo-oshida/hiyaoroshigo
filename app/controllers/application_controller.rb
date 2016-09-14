class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_festival
  before_action :check_current_festival_started

  private
  
  def authenticate_drinker!
    session[:drinker_return_to] = env['PATH_INFO']
    redirect_to login_path unless drinker_signed_in?
  end
  
  def after_sign_out_path_for(resource)
    "/login"
  end
  
  def set_current_festival
    @current_festival = Festival.find_by(name: "松江トランキーロ2016")
  end
  
  def current_festival
    @current_festival
  end
  
  def check_current_festival_started
    if !self.is_a?(Admin::ResourcesController) &&
        Time.current < current_festival.start_at
      redirect_to "/comingsoon"
    end
  end
end
