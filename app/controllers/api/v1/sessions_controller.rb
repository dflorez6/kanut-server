module Api
  module V1
    class SessionsController < Devise::SessionsController
      include Devise::Controllers::Helpers
      respond_to :json

      # POST /api/v1/users/sign_in
      def create
        resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        render json: { token: current_token, user: resource }
      end

      # DELETE /api/v1/users/sign_out
      def destroy
        sign_out
        head :no_content
      end

      private

      def current_token
        request.headers['Authorization']&.split(' ')&.last
      end

    end
  end
end