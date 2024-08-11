module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json

      private

      # POST /api/v1/users/sign_in
      # Customize the response for sign-in
      def respond_with(resource, _opts = {})
        render json: { user: resource, token: current_token }
      end

      # DELETE /api/v1/users/sign_out
      # Handle sign-out response
      def respond_to_on_destroy
        head :no_content
      end

      # Extract JWT token from the request
      def current_token
        request.env['warden-jwt_auth.token']
      end

    end
  end
end