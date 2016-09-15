class DrinkersController < ApplicationController
  before_action :authenticate_drinker!, only:[:edit, :edit_first, :show, :update]

  def redirector
    redirect_to "/drinker/auth/facebook?passcode=#{params[:passcode]}"
  end

  def login
    error = flash[:alert] if flash[:alert].present?
    reset_session
    flash.now[:alert] = error
  end

  def edit
    @drinker = current_drinker
  end

  def edit_first
    @drinker = current_drinker
  end

  def show
    @drinker = current_drinker
  end

  def update
    if params[:drinker][:name].present?
      current_drinker.name = params[:drinker][:name]
      current_drinker.save
    end
    if params[:drinker][:is_first].present?
      if current_drinker.name.present?
        redirect_to "/restaurants/vote"
      else
        redirect_to "/drinkers/edit_first",
          alert: "トランキーロネームを入力してください"
      end
    else
      redirect_to "/drinkers/edit"
    end
  end
end
