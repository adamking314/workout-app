Rails.application.routes.draw do
  get "profiles/show"
  get "pages/home"
  get "pages/profile"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  root "pages#home"
  
  # Defines the root path route ("/")
  # root "posts#index"
  Rails.application.routes.draw do
  # … any existing routes …

  # Add this line to route GET "/profile" to ProfilesController#show:
  get "/profile", to: "pages#profile"

  # (You can keep other routes below or above as needed.)
end

end
