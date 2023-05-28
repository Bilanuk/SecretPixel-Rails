class ImagesController < ApplicationController
  before_action :authenticate_and_set_user

  def index
    images = current_user.images.order(created_at: :desc).limit(3)
    render json: images, status: :ok
  end

  def show
    image = current_user.images.find(params[:id])
    render json: image, status: :ok
  end

  def create
    image = current_user.images.build(image_params)
    
    if image.save
      render json: image, status: :created
    else
      render json: { error: image.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def image_params
    params.permit(:file, :name)
  end
end