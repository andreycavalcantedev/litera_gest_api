Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :type_users
  resources :users
  resources :libraries

  post '/login', to: 'auth#login'
end
