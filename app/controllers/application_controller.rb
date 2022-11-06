# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  #for now we disable csrf token
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email password password_confirmation])
  end
end
