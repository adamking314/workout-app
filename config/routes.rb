Rails.application.routes.draw do
  get "workouts/index"
  get "workouts/show"
  # === API namespace ===
  namespace :api do
    # Users: signup (create) and show
    resources :users, only: [:create, :show]

    # Sessions: login (create) and logout (destroy)
    post   "/sessions",      to: "sessions#create"
    delete "/sessions/:id",  to: "sessions#destroy", as: :logout

    # Workouts: full CRUD (index, show, create, update, destroy)
    resources :workouts, only: [:index, :show, :create, :update, :destroy]
  end

  # === Static / server-rendered pages ===
  # If you have a ProfilesController#show:
  get "/profiles/show", to: "profiles#show"

  # If you have a PagesController with home + profile actions:
  get "/pages/home",    to: "pages#home"
  get "/pages/profile", to: "pages#profile"

  # Map "/profile" directly to PagesController#profile (shortcut)
  get "/profile", to: "pages#profile"

  # Health-check endpoint (optional)
  get "/up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "pages#home"
end
