# frozen_string_literal: true

module Users
  class RegistrationController < ApiGuard::RegistrationController
    private

    def sign_up_params
      params.permit(:email, :password, :username, :password_confirmation)
    end
  end
end
