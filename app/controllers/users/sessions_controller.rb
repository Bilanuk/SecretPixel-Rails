# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    def new
      render json: {
        message: "Only API"
      }, status: :bad_request
    end

    def create
      resource = warden.authenticate!({ scope: resource_name, recall: "#{controller_path}#log_in_failure" })

      sign_in(resource_name, resource)
      render json: {
        message: "You are successfully logged in.",
        user: current_user
      }, status: :ok
    end

    def destroy
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      return render json: {message: "You are successfully logged out."}, status: :ok if signed_out

      render json: {message: "Already logged out."}, status: :unauthorized
    end

    def log_in_failure
      render json: { message: "Invalid email or password." }, status: :unauthorized
    end

    protected

    def verify_signed_out_user
      render json: {message: "No active user"}, status: :ok if all_signed_out?
    end

    def require_no_authentication
      assert_is_devise_resource!

      no_input = devise_mapping.no_input_strategies

      authenticated = if no_input.present?
                        args = no_input.dup.push scope: resource_name
                        warden.authenticate?(*args)
                      else
                        warden.authenticated?(resource_name)
                      end

      if authenticated && resource = warden.user(resource_name)
        render json: {
          message: "You are already logged in.",
          user: current_user
        }, status: :ok
      end
    end
  end
end
