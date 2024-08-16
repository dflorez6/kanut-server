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
      # singular: :user -> will maintain the singular path for the user instead of api_v1_user_registration for ex
      devise_for :users, singular: "user", path: '/users', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      }, controllers: {
        sessions: 'api/v1/users/sessions',
        registrations: "api/v1/users/registrations"
      }

      #==========
      # Named Paths
      #==========
      #----------
      # Registration
      #----------
      # api_v1_user_registration
      # POST -> /api/v1/users/signup(.:format)
      # api/v1/users/registrations#create {:format=>:json}
      #----------
      # Login
      #----------
      # new_api_v1_user_session
      # GET -> /api/v1/users/login(.:format)
      # api/v1/users/sessions#new {:format=>:json}
      #----------
      # Logout
      #----------
      # destroy_api_v1_user_session
      # DELETE -> /api/v1/users/logout(.:format)
      # api/v1/users/sessions#destroy {:format=>:json}

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
