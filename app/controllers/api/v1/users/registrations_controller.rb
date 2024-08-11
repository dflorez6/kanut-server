module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      private

      # POST /api/v1/users/sign_up
      # Customize the response for sign-up
      def respond_with(resource, _opts = {})
        if resource.persisted?
          render json: { user: resource, token: current_token }
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # Extract JWT token from the request
      def current_token
        request.env['warden-jwt_auth.token']
      end
    end
  end
end