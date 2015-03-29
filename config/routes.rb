Rails.application.routes.draw do
  devise_for :users
  
  resources :users 
  resources :groups, only: [:new, :create, :show, :destroy]
  # TODO: add edit
  resources :tasks
  
  root to: "home#index"
end