# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    def new
      render json: {
        message: "Only API"
      }, status: :bad_request
    end

    def create
      build_resource(sign_up_params)
      resource.save
      if resource.persisted?
        if resource.active_for_authentication?
          sign_up(resource_name, resource)
          render json: {message: "Signed up sucessfully."}, status: :ok
        else
          expire_data_after_sign_in!
          respond_with resource
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        render json: {
          "message": "Registration failed",
          "errors": resource.errors
        }, status: :bad_request
      end
    end

    def update
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      resource_updated = update_resource(resource, account_update_params)
      if resource_updated
        bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

        render json: {message: "Updated successfully", user: current_user}, status: :ok
      else
        clean_up_passwords resource
        set_minimum_password_length
        render json: {
          "message": "Update failed",
          "errors": resource.errors
        }, status: :bad_request
      end
    end

    def destroy
      if resource.destroy
        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
        return render json: {"message": "User destroyed"}, status: :ok
      end

      render json: {"message": "Something went wrong"}, status: :unprocessable_entity
    end
  end
end
