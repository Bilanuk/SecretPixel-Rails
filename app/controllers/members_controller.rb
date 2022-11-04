# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: {
      message: "If you see this, you're in!",
      user:    user
    }
  rescue StandardError
    render json: {'message': "invalid auth token"}, status: :unprocessable_entity
  end

  private

  def user
    jwt_payload = JWT.decode(request.headers["Authorization"].split(" ")[1], ENV["RAILS_SECRET_KEY"]).first
    user_id = jwt_payload["sub"]
    User.find(user_id.to_s)
  end
end
