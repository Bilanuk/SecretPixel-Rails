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

    get '/playlist/:id', to: "playlists#show"
    get '/playlists', to: "playlists#index"
    get '/recent-playlists', to: "playlists#get_recent_playlists_by_date"
    get '/recomended-playlists', to: "playlists#get_recomended_playlists"

    get "/user-info", to: "users#show" # just for test purpose
    post "/playlist", to: "playlists#create"
  end
end
