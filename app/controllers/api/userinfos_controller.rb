class Api::UserinfosController < ApplicationController
  before_action :authenticate_user!

  def userinfo
    @current_user = current_user
    # puts current_user.class
    render json: @current_user
  end

end
