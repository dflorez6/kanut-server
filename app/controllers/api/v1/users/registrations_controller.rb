module Api
  module V1
    module Users
      class Users::RegistrationsController < Devise::RegistrationsController
        # binding.pry  # TODO: Used for debugging
        include RackSessionsFix # Fix to Rails 7 Api with Devise
        respond_to :json

        def create
          super
        end

        # TODO: FIND WHERE THE SIGNUP OBJECT IS CREATED AND WHAT INFO IS RETURNED TO PREVENT JTI FROM BEING SHOWN

        private

        # Customizes the response after a user registration attempt.
        # Params:
        # * current_user: The user object representing the newly registered user.
        # * _opts: Additional options that Devise might pass.
        def respond_with(current_user, _opts = {})
          # Checks if the user object has been successfully persisted in the database.
          if resource.persisted?
            render json: {
              status: { code: 200, message: "Signed up successfully." },
              data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
            }
          else
            render json: {
              status: {message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"}
            }, status: :unprocessable_entity
          end

        end

        # Override Devise sign_up_params to explicitly define the accepted parameters
        def sign_up_params
          params.require(:user).permit(:email, :password, :password_confirmation)
        end

      end
    end
  end
end

