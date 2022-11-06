# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users,
                 controllers: {
                   sessions:      "users/sessions",
                   registrations: "users/registrations"
                 }
      get "/member-data", to: "members#show" # just for test purpose
    end
  end
end
