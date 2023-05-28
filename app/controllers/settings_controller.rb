class SettingsController < ApplicationController
  before_action :authenticate_and_set_user

  def show
    render json: current_user.setting
  end
end