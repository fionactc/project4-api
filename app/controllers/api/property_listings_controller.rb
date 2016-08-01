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
    @property_listing = current_agent.property_listings.new(property_listing_params)
    if @property_listing.save
      render 'show'
    else
      render json: @property_listing.errors.messages, status: 400
    end
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
    params.permit(:apartment_id, :enquiry_agent_id)
  end

end
