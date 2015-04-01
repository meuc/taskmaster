Rails.application.routes.draw do
  devise_for :users

  get "/tasks/add_suggested", to: "tasks#add_suggested"
  post "/tasks/add_suggested", to: "tasks#create_suggested"

  resources :users 
  resources :groups, only: [:new, :create, :show, :destroy]
  # TODO: add edit
  resources :tasks

  root to: "home#index"
end