class AgentsController < ApplicationController
  before_action :authenticate_user!, only: [:secret]
  def signup
  end
  def login
  end

  def secret
    render json: current_user
  end
end
