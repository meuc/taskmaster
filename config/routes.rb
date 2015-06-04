Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  get "/tasks/add_suggested", to: "tasks#add_suggested"
  post "/tasks/add_suggested", to: "tasks#create_suggested"

  resources :users, only: [:show, :destroy]
  resources :groups, only: [:new, :create, :show, :destroy]
  resources :comments
  resources :graphs, only: [:index]
  
  get "/assignments/edit", to: "assignments#edit", as: "edit_assignments"
  put "/assignments", to: "assignments#update", as: "assignments"
  get "/assignments/auto", to: "assignments#auto", as: "auto_assignments"
  
  delete "/groups/:id/leave", to: "groups#leave", as: "leave_group"
  get "/groups/:id/choose_user", to: "groups#choose_user", as: "choose_user"
  post "/groups/:id/add_user", to: "groups#add_user", as: "add_user"

  resources :tasks do
    member do
      patch "toggle_completed"
    end
  end
  # same as the post stuff, just nicer in this case

  get "/contact", to: "contact#new"
  post "/contact", to: "contact#create"

  root to: "home#index"
end
