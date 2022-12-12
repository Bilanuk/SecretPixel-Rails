# frozen_string_literal: true

class TrackController < ApplicationController
  # before_action :authenticate_and_set_user

  def index
    render json: Track.all, each_serializer: Track::IndexSerializer
  end

  def show
    render json: Track.find(params[:id]), serializer: Track::ShowSerializer
  end
end
