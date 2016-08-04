class Api::PropertyListingsController < ApplicationController
  before_action :authenticate_agent!, only: [:create, :destroy]
  before_action :authenticate_user!, only: [:index, :show, :update]
  before_action :set_property_listing, only:  [:show, :update, :destroy]

  def index
    @property_listings = Property_listing.all
  end

  def show
  end

  def create
    @propertyListings = [];
    params[:apartments].each do |id|
      newlisting = PropertyListing.create(apartment_id: id, renter_id: params[:renter_id], agent_id: current_agent.id, enquiry_id: params[:enquiry_id])
      @propertyListings.push(newlisting);
    end
    render json: @propertyListings
    # puts '------------------'
    # puts params[:chat_id]
    # EnquiryAgent.where(agent_id: )
    # puts params[:apartments]
    # params[:apartments].each do |id|
    #   PropertyListing.create()
    # end
    # puts '------------------'

    # chat = Chat.find(params[:chat_id]);
    # renter_id = chat.renter_id;
    # Renter.find(renter_id)
    # Chat.find(params[:chat_id]).renter.

    # enquiry_agent = EnquiryAgent.where(chat_id: params[:chat_id], agent_id: current_agent.id);
    # @property_listing = PropertyListing.new(agent_id: current_agent.id, enquiry_id: enquiry_agent.enquiry_id)

    # @property_listing = current_renter.property_listings.new(property_listing_params)
    # if @property_listing.save
    #   render 'show'
    # else
    #   render json: @property_listing.errors.messages, status: 400
    # end
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
    params.permit(:apartments, :renter_id, :enquiry_id)
    # link property_listing to enquiry, agents and renters
    # i DONT HAVE FUCKING CURRENT_RENTER
    # I have chat.ID = can get agent_id, renter_id => then can get enquiry_agent=> then can get enquiry
  end

end
