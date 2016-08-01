class Api::RenterRatingsController < ApplicationController
  before_action :authenticate_agent!, except: [:index, :show]
  before_action :set_renter_ratings, only:  [:show, :update]

  def index
    @renter_ratings = Renter_rating.all
  end

  def show
  end

  def create
    @renter_rating = current_agent.renter_ratings.new(renter_rating_params)
    if @renter_rating.save
      render 'show'
    else
      render json: @renter_rating.errors.messages, status: 400
    end
  end

  def update
    @renter_rating.assign_attributes(renter_rating_params)
    if @renter_rating.save
      render 'show'
    else
      render json: {errors: @renter_rating.errors.messages}, status: 400
    end
  end

private

  def set_renter_rating
    @renter_rating = Renter_rating.find_by_id(params[:id])
    if @renter_rating.nil?
      render json: {message: "Cannot find renter_rating with ID #{params[:id]}"}
    end
  end

  # refer to schema
  def renter_rating_params
    params.permit(:rr_overall_star, :rr_comment, :no_show, :spy, :agent_id, :renter_id, :appointment_id)
  end


end
