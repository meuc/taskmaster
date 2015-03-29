Rails.application.routes.draw do
  devise_for :users
  
  resources :users 
  resources :groups, only: [:new, :create, :show]
  # TODO: add edit, delete
  
  root to: "home#index"
end