class Api::AgentRatingsController < ApplicationController
  before_action :authenticate_renter!, except: [:index, :show]
  before_action :set_agent_ratings, only:  [:show, :update]

  def index
    @agent_ratings = AgentRating.all
  end

  def show
  end

  def create
    @agent_rating = AgentRating.new(agent_rating_params)
    # @agent_rating = current_renter.agent_ratings.new(agent_rating_params)
    if @agent_rating.save
      render 'show'
    else
      render json: @agent_rating.errors.messages, status: 400
    end
  end

  def update
    @agent_rating.assign_attributes(agent_rating_params)
    if @agent_rating.save
      render 'show'
    else
      render json: {errors: @agent_rating.errors.messages}, status: 400
    end
  end

private

  def set_agent_rating
    @agent_rating = AgentRating.find_by_id(params[:id])
    if @agent_rating.nil?
      render json: {message: "Cannot find agent_rating with ID #{params[:id]}"}
    end
  end

  # refer to schema
  def agent_rating_params
    params.permit(:ar_overall_star, :ar_commment, :agent_id, :renter_id, :appointment_id)
  end
end
