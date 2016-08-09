class Api::PropertyListingsController < ApplicationController
  before_action :authenticate_agent!, only: [:create, :destroy]
  before_action :authenticate_user!, only: [:index, :show, :update]
  before_action :set_property_listing, only:  [:show, :update, :destroy]

  def index
    # @property_listings = PropertyListing.all
    # @property_listings = current_renter.property_listings.group_by{|x|x.agent.email}
    @property_listings = PropertyListing.includes(:apartment).where(renter_id: current_renter.id).group_by{|x|x.agent}
     # @property_listings = PropertyListing.includes(:apartment).where(renter_id: current_renter.id).group_by{|x|x.agent}
    # }
    # }
    # render json: @property_listings
  end

  def show
    # pass in agent_id, if cant, pass in chat_id
    @property_listings = PropertyListing.where(renter_id: current_renter.id, agent_id: params[:agent_id]).group_by {|x|x.enquiry}
    render json: @property_listings

  end

  def create
    @propertyListings = [];
    @message = current_agent.messages.create(listing_title: params[:title], chat_id: params[:chat_id], message_type: 'listing', body: 'I have sent ' + params[:apartments].count.to_s + ' new listing(s) to you.')
    if @message.save
      params[:apartments].each do |id|
        newlisting = PropertyListing.create(apartment_id: id, renter_id: params[:renter_id], agent_id: current_agent.id, message_id: @message.id)
        @propertyListings.push(newlisting);
      end
    else
      render json: @message.errors.messages
    end
  end

  def getlistings
    @listings = PropertyListing.includes(:apartment).where(message_id: params[:messageId])
    # render json: @listings
  end

  def update
    @property_listing.assign_attributes(property_listing_params)
    if @property_listing.save
      render 'show'
    else
      render json: {errors: @property_listing.errors.messages}, status: 400
    end
  end

  def destroy
    @property_listing.destroy
  end

private

  def set_property_listing
    @property_listing = Property_listing.find_by_id(params[:id])
    if @property_listing.nil?
      render json: {message: "Cannot find property_listing with ID #{params[:id]}"}
    end
  end

  # refer to schema
  def property_listing_params
    params.permit(:apartments, :renter_id, :title, :chat_id)

  end

end
