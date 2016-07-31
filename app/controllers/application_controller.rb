class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
    before_action :get_current_renter
    before_action :get_current_agent

  def authenticate_renter!
    render json: {message: "Unauthorize"} if current_renter.nil?
  end

  def get_current_renter
    return nil unless cookies[:auth_headers]
    auth_headers = JSON.parse cookies[:auth_headers]

    expiration_datetime = DateTime.strptime(auth_headers["expiry"], "%s")
    current_renter = Renter.find_by(uid: auth_headers["uid"])

    if current_renter &&
       current_renter.tokens.has_key?(auth_headers["client"]) &&
       expiration_datetime > DateTime.now

      @current_renter = current_renter
    end
    @current_renter
  end

  def authenticate_agent!
    render json: {message: "Unauthorize"} if current_agent.nil?
  end

  def get_current_agent
    return nil unless cookies[:auth_headers]
    auth_headers = JSON.parse cookies[:auth_headers]

    expiration_datetime = DateTime.strptime(auth_headers["expiry"], "%s")
    current_agent = Agent.find_by(uid: auth_headers["uid"])

    if current_agent &&
       current_agent.tokens.has_key?(auth_headers["client"]) &&
       expiration_datetime > DateTime.now

      @current_agent = current_agent
    end
    @current_agent
  end
end
