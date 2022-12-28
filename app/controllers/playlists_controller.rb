# frozen_string_literal: true

class PlaylistsController < ApplicationController
  before_action :authenticate_and_set_user, only: [:create, :index, :get_recent_playlists_by_date]

  def index
    render json: current_resource.playlists, each_serializer: Playlists::ShowSerializer
  end

  def show
    render json: Playlist.find(params[:id]), serializer: Playlists::ShowSerializer
  end

  def get_recent_playlists_by_date
    render json: current_resource.playlists.order(created_at: :desc), each_serializer: Playlists::ShowSerializer
  end
  

  def get_recomended_playlists
    render json: Playlist.all.order("RANDOM()"), each_serializer: Playlists::ShowSerializer
  end

  def create
    ActiveRecord::Base.transaction do
      playlist = current_resource.playlists.build(title: params[:title])
      playlist.save


      Track.create(tracks_params.map { |track| track.merge(author: current_resource, playlist: playlist) })
    end

    if playlist
      render json: playlist, serializer: Playlists::ShowSerializer
    else
      render json: { errors: playlist.errors }, status: :unprocessable_entity
    end
  end

  def tracks_params
    params.require(:tracks).values
  end
end
