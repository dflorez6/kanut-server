module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        include RackSessionsFix # Fix to Rails 7 Api with Devise
        respond_to :json

        def destroy
          @authenticated = true
          super
        end

        private

        def verify_signed_out_user
          current_user
          super
        end

        # Customizes the response after a user logs in successfully.
        # Params:
        # - current_user: The user object representing the logged-in user.
        # - _opts: Additional options that Devise might pass.
        def respond_with(current_user, _opts = {})
          render json: {
            status: {
              code: 200, message: "Logged in successfully.",
              data: {
                user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] # Serializes the user data for the response.
              }
            }
          }, status: :ok
        end

        # Handles the response when a user logs out or the session is destroyed.
        def respond_to_on_destroy
          # Checks if the Authorization header is present, indicating an active session.
          if request.headers['Authorization'].present?
            # Decodes the JWT token from the Authorization header to retrieve the user ID (sub).
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, ENV["DEVISE_JWT_SECRET_KEY"]).first
            current_user = User.find(jwt_payload['sub']) # Finds the user based on the decoded JWT payload.
          end

          if current_user
            # If the user is found, return a JSON response indicating successful logout
            render json: {
              status: 200,
              message: "Logged out successfully."
            }, status: :ok
          else
            # If the user is not found, return a JSON response indicating no active session
            render json: {
              status: 401,
              message: "Couldn't find an active session."
            }, status: :unauthorized
          end
        end

      end
    end
  end
end

