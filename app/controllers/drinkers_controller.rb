class DrinkersController < ApplicationController
  before_action :authenticate_drinker!, only:[:edit, :show, :update]

  def redirector
    if params[:passcode].present?
      redirect_to '/drinker/auth/facebook?passcode='+params[:passcode]
    else
      redirect_to '/login'
    end
  end

  def login
    error = flash[:alert] if flash[:alert].present?
    reset_session
    flash.now[:alert] = error
  end

  def edit
    @drinker = current_drinker
  end

  def show
    @drinker = current_drinker
  end

  def update
    drinker = current_drinker
    drinker.name = params[:drinker][:name]
    drinker.save
    redirect_to "/drinkers/edit"
  end
end
