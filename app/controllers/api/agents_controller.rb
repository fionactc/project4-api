class Api::AgentsController < ApplicationController
  before_action :authenticate_agent!, except: [:index, :show]
  before_action :set_agent, only: [:show]

  def index
    @agents = Agent.includes(:apartments).all
  end

  def show
  end

  def create
    @agent = current_agent.new(agent_params)
    if @agent.save

      # match agents to past enquiries
      render 'show'
    else
      render json: @agent.errors.messages, status: 400
    end
  end

  def match
    areas = @agent.areas
    areas.each do |area|
      matched_enquiries = Enquiry.where("'#{area}' = ANY (areas)")
      matched_enquiries.each do |enquiry|
        EnquiryAgent.create(agent_id: @agent.id, enquiry_id: enquiry.id)
      end
    end
  end

  def update
    puts agent_params
    current_agent.assign_attributes(agent_params)
    if current_agent.save
      # render 'show'
      render json: {current_agent: current_agent, avatar: current_agent.avatar.url(:medium)}
    else
      render json: {errors: current_agent.errors.messages}, status: 400
    end
  end

  def destroy
    current_agent.destroy
  end

private

  def set_agent
    @agent = Agent.includes(:apartments).find_by_id(params[:id])
    if @agent.nil?
      render json: {message: "Cannot find agent with ID #{params[:id]}"}
    end
  end

  # refer to schema
  def agent_params
    params.permit(:email, :name, :first_name, :family_name, :mobile_number, :agent_avg_ratings, :nickname, :description, :website, :avatar, :license_num, :company_website, :license_file, :company_logo, :company_license_num, :branch_address, :branch_phone, :branch_fax, :salutation, :areas => [])
  end

end