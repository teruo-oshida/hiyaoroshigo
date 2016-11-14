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
    @current_festival = Festival.find_by(name: "ShimaneCommunities2016")
  end
  
  def current_festival
    @current_festival
  end
  
  def check_current_festival_started
    if !self.is_a?(Admin::ResourcesController) && !current_festival.started?
      redirect_to "/comingsoon"
    end
  end
  
  def check_current_festival_not_ended
    if current_festival.ended?
      redirect_to "/itstoolate"
    end
  end

  def restaurant_drinkings(restaurant)
    Drinking.where(drinker:    current_drinker,
                   festival:   current_festival,
                   restaurant: restaurant)
  end
end
