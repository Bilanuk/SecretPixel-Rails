class ImagesController < ApplicationController
  before_action :authenticate_and_set_user

  def show
    image = current_user.images.find(params[:id])
    render json: image
  end
end