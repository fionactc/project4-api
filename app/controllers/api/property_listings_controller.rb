class Api::PropertyListingsController < ApplicationController
  before_action :authenticate_agent!, only: [:create, :destroy]
  before_action :authenticate_user!, only: [:index, :show, :update]
  before_action :set_property_listing, only:  [:show, :update, :destroy]

  def index
    @property_listings = PropertyListing.all
  end

  def show
    # pass in agent_id, if cant, pass in chat_id
    @property_listings = PropertyListing.where(renter_id: current_renter.id, agent_id: params[:agent_id]).group_by {|x|x.enquiry}
    render json: @property_listings

  end

  def create
    @propertyListings = [];
    params[:apartments].each do |id|
      newlisting = PropertyListing.create(apartment_id: id, renter_id: params[:renter_id], agent_id: current_agent.id, enquiry_id: params[:enquiry_id])
      @propertyListings.push(newlisting);
    end
    @message = current_agent.messages.create(chat_id: params[:chat_id], body: 'I have sent ' + @propertyListings.count.to_s + ' new listing(s) to you.', message_type: 'listing')
    @propertyListings
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

  end

end
