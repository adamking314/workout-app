Rails.application.routes.draw do
  # === API namespace ===
  namespace :api do
    # Users: sign up (create) and show
    resources :users, only: [:create, :show]
    
    resources :saved_workouts, only: [:index, :create, :destroy]
    # Sessions: log in (create), log out (destroy), and “authenticated” check
    resources :sessions, only: [:create, :destroy]
    get 'authenticated', to: 'sessions#authenticated'
    delete '/sessions', to: 'sessions#destroy'
    # Workouts: user-specific index plus full CRUD
    get  '/users/:username/workouts', to: 'workouts#user_workouts'
    resources :workouts, only: [:index, :show, :create, :update, :destroy]
  end

  # === Static / server-rendered pages ===

  # If you use a PagesController for home + profile:
  get "/pages/home",    to: "pages#home"
  get "/pages/profile", to: "pages#profile"

  # Shortcut: map "/profile" → PagesController#profile
  get "/profile", to: "pages#profile"

  # If you had a ProfilesController#show (optional)
  # get "/profiles/show", to: "profiles#show"

  # Health-check endpoint (optional)
  get "/up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "pages#home"
end
