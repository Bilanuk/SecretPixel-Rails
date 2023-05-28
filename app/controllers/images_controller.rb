class ImagesController < ApplicationController
  before_action :authenticate_and_set_user

  def index
    images = current_user.images.order(created_at: :desc).limit(3)
    render json: images
  end

  def show
    image = current_user.images.find(params[:id])
    render json: image
  end
end