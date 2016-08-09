class Api::RenterRatingsController < ApplicationController
  before_action :authenticate_agent!, except: [:index, :show]
  before_action :set_renter_ratings, only:  [:show, :update]

  def index
    @renter_ratings = RenterRating.includes(:appointment, :renter, :agent).all
  end

  def show
  end

  def create
    @renter_rating = RenterRating.new(renter_rating_params)
    if @renter_rating.save
      render 'show'
    else
      render json: @renter_rating.errors.messages, status: 400
    end
  end

  def update
    @renter_rating.assign_attributes(renter_rating_params)
    @renter_rating.update_attributes(done: true)

    if @renter_rating.save
      # if nil set a value, if not average the values
      if @renter.renter_avg_ratings.nil?
        @renter.update_attributes(renter_avg_ratings: @renter_rating.rr_overall_star)
      else
        arr = [@renter_rating.rr_overall_star, @renter.renter_avg_ratings]
        avg = arr.inject{ |sum, el| sum + el }.to_f / arr.size
        @renter.update_attributes(renter_avg_ratings: avg)
      end

      render 'show'
    else
      render json: {errors: @renter_rating.errors.messages}, status: 400
    end
  end

private

  def set_renter_rating
    @renter_rating = RenterRating.includes(:appointment, :renter, :agent).find_by_id(params[:id])
    if @renter_rating.nil?
      render json: {message: "Cannot find renter_rating with ID #{params[:id]}"}
    end
  end

  # refer to schema
  def renter_rating_params
    params.permit(:rr_overall_star, :rr_comment, :no_show, :spy, :agent_id, :renter_id, :appointment_id, :done)
  end

end