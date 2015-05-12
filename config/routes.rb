Rails.application.routes.draw do
  devise_for :users

  get "/tasks/add_suggested", to: "tasks#add_suggested"
  post "/tasks/add_suggested", to: "tasks#create_suggested"

  resources :users 
  resources :groups, only: [:new, :create, :show, :destroy]
  delete "/groups/:id/leave", to: "groups#leave", as: "leave_group"
  get "/groups/:id/choose_user", to: "groups#choose_user", as: "choose_user"
  post "/groups/:id/add_user", to: "groups#add_user", as: "add_user"
  # TODO: add edit
  resources :tasks do
    member do
      patch "toggle_completed"
    end
  end
  # same as the post stuff, just nicer in this case

  root to: "home#index"
end