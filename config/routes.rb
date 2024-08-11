Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #====================
  # Health Check
  #====================
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  #====================
  # API
  #====================
  namespace :api, defaults: { format: :json } do
    # v1
    namespace :v1 do
      # Authentication (Devise)
      devise_for :users, controllers: {
        sessions: "api/v1/users/sessions",
        registrations: "api/v1/users/registrations"
      }

      # Resources
      resources :users
      # TODO: Add resources routes here
    end

    # API v2
    # TODO: API v2
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
