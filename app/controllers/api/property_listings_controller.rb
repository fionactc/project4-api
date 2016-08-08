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

    @message = current_agent.messages.create(listing_title: params[:title], chat_id: params[:chat_id], message_type: 'listing')
    puts '--------look at message------'
    puts @message.id
    puts '--------look at message------'
    puts '--------look at message------'
    puts '--------look at message------'
    params[:apartments].each do |id|
      newlisting = PropertyListing.create(apartment_id: id, renter_id: params[:renter_id], agent_id: current_agent.id, message_id: @message.id)
      puts newlisting
      @propertyListings.push(newlisting);
    end
    @message.update_attributes(body: 'I have sent ' + @propertyListings.count.to_s + ' new listing(s) to you.')
    @propertyListings
  end

  # @message = current_agent.messages.create(chat_id: params[:chat_id], body: 'I have sent ' + @propertyListings.count.to_s + ' new listing(s) to you.', message_type: 'listing')

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
    params.permit(:apartments, :renter_id, :title)

  end

end
