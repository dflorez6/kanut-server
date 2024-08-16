# class ApplicationController < ActionController::Base # TODO: GPT
class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Devise: Permit additional parameters for sign up
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation first_name last_name name]) # TODO: Add avatar/photo
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email password password_confirmation first_name last_name name]) # TODO: Add avatar/photo
  end

end

