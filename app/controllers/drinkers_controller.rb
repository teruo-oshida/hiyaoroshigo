class DrinkersController < ApplicationController
  def redirecter
    redirect_to '/drinker/auth/facebook?passcode='+params[:passcode]
  end
end
