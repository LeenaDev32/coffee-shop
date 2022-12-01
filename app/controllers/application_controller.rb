class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!, unless: :auth_controller

  private

  def auth_controller
    is_a?(DeviseTokenAuth::RegistrationsController) || is_a?(DeviseTokenAuth::SessionsController)
  end
end
