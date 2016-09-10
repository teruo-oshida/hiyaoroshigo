class DrinkersController < ApplicationController
  def edit
    @drinker = Drinker.first
  end

  def show
    puts current_drinker
    @drinker_name = Drinker.first.name
  end

  def update
    p params[:drinker][:name]
    drinker = Drinker.first
    drinker.name = params[:drinker][:name]
    drinker.save
    redirect_to :action => "show"
  end
end
