Rails.application.routes.draw do
  get 'festivals/thewinner'

  get 'sakes/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :terms, only: [:show]
  get :signup, to: "drinkers#redirector"
  get :login, to: "drinkers#login"
  resources :festivals, only: [:index, :show]
  get "/restaurants/vote", to: "restaurants#vote"
  get "/restaurants/map", to: "restaurants#map"
  resources :restaurants, only: [:show]
  get "/drinkers/edit", to: "drinkers#edit"
  get "/drinkers/edit_first", to: "drinkers#edit_first"
  resource :drinkers, only: [:edit, :update]
  resources :drinkings, only: [:show, :new, :create, :destroy]
  get :comingsoon, to: "festivals#comingsoon"
  get :itstoolate, to: "festivals#itstoolate"
  get :thewinner, to: "festivals#thewinner"
  resources :checkins, only: [:new, :create]
  root "restaurants#vote"
end
