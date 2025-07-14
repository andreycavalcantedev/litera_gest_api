Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :type_users
  resources :users do
    post :create_collaborator, on: :collection
  end
  resources :libraries
  resources :books do
    post :loan_book, on: :member
  end

  post '/login', to: 'auth#login'
  delete '/logout', to: 'auth#logout'
end
