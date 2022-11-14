# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
    scope :auth do
      api_guard_routes for: "users", controller: {
        registration:   "users/registration",
        authentication: "users/authentication",
        passwords:      "users/passwords",
        tokens:         "users/tokens"
      }
    end

    get "/user-info", to: "users#show" # just for test purpose
  end
end
