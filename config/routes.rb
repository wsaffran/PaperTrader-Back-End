Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :create]
  resources :games, only: [:index]
  resources :game_players, only: [:index, :show, :update]
  resources :transactions, only: [:index, :create, :update]
  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"
  get "/auto_login", to: "auth#auto_login"
  post "/new_game", to: "games#new_game"
  post "/join_game", to: "game_players#join_game"
  get "/games/:id/rankings", to: "games#rankings"
  get "/portfolio/:game_player_id", to: "game_players#portfolio"
  post "/transactions/buy", to: "transactions#buy"

end
