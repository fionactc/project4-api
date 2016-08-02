class StaticsController < ApplicationController
  # for testing
  def home
    # Test 1: find agent by region
    # region = 'Kowloon'
    # agents = Agent.where("'#{region}' = ANY (regions) ")
    # render json: agents[1].id

    # Test 2: find matched renters of current agent
    # @renter = []
    # matched_enquiries_agents = current_agent.enquiry_agents
    # matched_enquiries_agents.each do |match|
    #   @renter.push(match.enquiry.renter)
    # end
    # render json: @renter

  end
end
