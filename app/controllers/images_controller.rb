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

  def update
    image = current_user.images.find(params[:id])
    message = params[:message]
    updated_image = MessageService.embed_message(image, message)

    if updated_image.save
      Message.create(content: message, message_type: :sent, user: current_user)
      render json: updated_image, status: :ok
    else
      render json: { error: updated_image.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def read_message
    image = current_user.images.find(params[:id])
    message = MessageService.extract_message(image)

    if message
      Message.create(content: message, message_type: :received, user: current_user)
      render json: { message: message }, status: :ok
    else
      render json: { error: "No message found" }, status: :not_found
    end
  end

  def generate_dependent_bmp
    image = current_user.images.find(params[:id])
    color_dependency = params[:color_dependency]

    result = BmpCreationService.generate_dependent_bmp(image, color_dependency)

    render json: result, status: :ok
  end

  private

  def image_params
    params.require(:image).permit(:file, :name)
  end
end