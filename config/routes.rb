Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :create]
  resources :games, only: [:index]
  resources :game_players, only: [:index]
  resources :transactions, only: [:index, :create]
  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"
  get "/auto_login", to: "auth#auto_login"
  post "/new_game", to: "games#new_game"
  post "/join_game", to: "game_players#join_game"



end
