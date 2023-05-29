class MessagesController < ApplicationController
  before_action :authenticate_and_set_user

  def show
    message = current_user.messages.find(params[:id])
    render json: message
  end

  def show_received_messages
    messages = current_user.received_messages.order(created_at: :desc).limit(3)
    render json: messages
  end

  def show_sent_messages
    messages = current_user.sent_messages.order(created_at: :desc).limit(3)
    render json: messages
  end

  def create_sent_message
    content = params[:content]
    image = Image.find(params[:image_id])
    message = Message.create_sent_message(current_user, content, image)

    render json: message, status: :created
  end

  def create_received_message
    content = params[:content]
    image = Image.find(params[:image_id])
    message = Message.create_received_message(current_user, content, image)

    render json: message, status: :created
  end
end