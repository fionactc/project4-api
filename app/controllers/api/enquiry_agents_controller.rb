class Api::EnquiryAgentsController < ApplicationController
  before_action :authenticate_agent!

  # return all matched renters for current_agent
  def index
    @matched_renters = []
    matched_enquiries_agents = current_agent.enquiry_agents
    matched_enquiries_agents.each do |match|
      @matched_renters.push(match.enquiry.renter)
    end
    render json: @matched_renters
  end
end
