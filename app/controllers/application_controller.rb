class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers

  before_action :authenticate_user!

  protected

  def authenticate_user!
    super
    render json: { error: "Unauthorized" }, status: :unauthorized unless user_signed_in?
  end
end
