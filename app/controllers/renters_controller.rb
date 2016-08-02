class RentersController < ApplicationController
  before_action :authenticate_user!, only: [:secret]

  def signup
  end

  def login
  end

  def secret
    # user = env['warden'].user(:renter)
    # render json: user
    render json: current_user
  end
end
