class MessagesController < ApplicationController
  before_action :authenticate_and_set_user

  def show
    message = current_user.messages.find(params[:id])
    render json: message
  end
end