# frozen_string_literal: true

class PlaylistsController < ApplicationController
  # before_action :authenticate_and_set_user

  def index
    render json: Playlist.all, each_serializer: Playlists::ShowSerializer
  end

  def show
    render json: Playlist.find(params[:id]), serializer: Playlists::ShowSerializer
  end
end
