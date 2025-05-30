Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :type_users
  resources :users do
    post :create_collaborator, on: :collection
  end
  resources :libraries

  post '/login', to: 'auth#login'
  delete '/logout', to: 'auth#logout'
end
