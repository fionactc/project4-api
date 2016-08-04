class Api::EnquiryAgentsController < ApplicationController
  before_action :authenticate_agent!

  # return all matched renters for current_agent
  def index
    # @matched_enquiries = []
    @matched_enquiries_agents = current_agent.enquiry_agents.includes(:enquiry)
    # matched_enquiries_agents.each do |match|
    #   @matched_enquiries.push(match.enquiry)
    # end
    # render json: @matched_enquiries_agents
  end
end
