Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"
  get "/auto_login", to: "auth#auto_login"

end
