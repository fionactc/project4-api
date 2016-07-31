class AgentsController < ApplicationController
  before_action :authenticate_agent!, only: [:secret]
  def signup
  end
  def login
  end

  def secret
    render json: @current_agent
  end
end
