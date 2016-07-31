class RentersController < ApplicationController
  before_action :authenticate_renter!, only: [:secret]
  def signup
  end

  def login
  end

  def secret
    render json: @current_renter
  end
end
