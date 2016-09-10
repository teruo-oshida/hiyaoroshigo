class CheckinController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end
end
