# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # for now we disable csrf token
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
end
