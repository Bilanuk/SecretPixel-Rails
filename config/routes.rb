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

      resource :setting, only: [:show]
      resources :messages, only: [:show]
      resources :images, only: [:show, :index, :create, :update]

    get "/user-info", to: "users#show" # just for test purpose
    get "/images/:id/read_message", to: "images#read_message"
    post "/images/generate_dependent_bmp", to: "images#generate_dependent_bmp"
  end
end
