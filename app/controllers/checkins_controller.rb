class CheckinsController < ApplicationController
  def new
    @restaurants = Restaurants.all
  end
end
