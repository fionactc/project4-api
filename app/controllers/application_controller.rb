class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session
  before_action :get_current_renter
  before_action :get_current_agent
  before_action :get_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?


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

  def authenticate_user!
    render json: {message: "Unauthorize"} if current_user.nil?
  end

  def get_current_user
    if current_agent.nil? && current_renter.nil?
      return nil
    end
    @current_user = current_agent.nil? ? current_renter : current_agent
  end

  def current_user
    @current_user
  end

protected

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :mobile_number]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
