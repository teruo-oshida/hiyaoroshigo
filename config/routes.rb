Rails.application.routes.draw do
  get 'festivals/thewinner'

  get 'sakes/index'

  get 'drinkings/new'

  get 'drinkings/create'

  devise_for :drinker, controllers:{ omniauth_callbacks: "drinker/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :terms, only: [:show]
  get :signup, to: "drinkers#redirector"
  get :login, to: "drinkers#login"
  resources :festivals, only: [:index, :show]
  get "/restaurants/map", to: "restaurants#map"
  resources :restaurants, only: [:index, :show] do
    resources :sakes, only: [:index]
  end
  resources :drinkers, only: [:update]
  get "/drinkers/edit", to: "drinkers#edit"
  post "/drinker/", to: "drinkers#update"
  resources :drinkings, only: [:index, :new, :create, :delete]
  get :itsitoolate, to: "festivals#itstoolate"
  get :thewinner, to: "festivals#thewinner"
  resources :checkins, only: [:new, :create]
end
