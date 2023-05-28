# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_and_set_user, only: [:show]

  def show
    render json: current_user, serializer: UserSerializer, status: :ok
  end
end
