class Api::AgentRatingsController < ApplicationController
  before_action :authenticate_renter!, except: [:index, :show]
  before_action :set_agent_rating, only: [:show, :update]
  before_action :set_agent, only: [:create]

  def index
    @agent_ratings = AgentRating.all
  end

  def show
  end

  def create
    @agent_rating = AgentRating.new(agent_rating_params)
    # @agent_rating = current_renter.agent_ratings.new(agent_rating_params)
    if @agent_rating.save
      if @agent.agent_avg_ratings.nil?
        @agent.update_attributes(agent_avg_ratings: @agent_rating.ar_overall_star)
      end
      arr = [@agent_rating.ar_overall_star, @agent.agent_avg_ratings]
      avg = arr.inject{ |sum, el| sum + el }.to_f / arr.size
      @agent.update_attributes(agent_avg_ratings: avg)

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

  def set_agent
    @agent = Agent.find_by_id(@agent_rating.agent_id)
  end

  # refer to schema
  def agent_rating_params
    params.permit(:ar_overall_star, :ar_commment, :agent_id, :renter_id, :appointment_id)
  end

end
