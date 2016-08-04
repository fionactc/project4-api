class Api::ApartmentsController < ApplicationController
  before_action :authenticate_agent!, except: [:index, :show]
  before_action :set_apartment, only:  [:show, :update]

  def index
    @apartments = Apartment.all
  end

  def show
  end

  def create
    @apartment = current_agent.apartments.new(apartment_params)
    if @apartment.save
      render 'show'
    else
      render json: @apartment.errors.messages, status: 400
    end
  end

  def update
    @apartment.assign_attributes(apartment_params)
    if @apartment.save
      render 'show'
    else
      render json: {errors: @apartment.errors.messages}, status: 400
    end
  end

  def destroy
    @apartment.destroy
  end

private

  def set_apartment
    @apartment = Apartment.find_by_id(params[:id])
    if @apartment.nil?
      render json: {message: "Cannot find apartment with ID #{params[:id]}"}
    end
  end

  # refer to schema
  def apartment_params
    params.permit(:apt_name, :street, :area, :property_size_gross, :property_size_net, :price, :bedroom_num, :bathroom_num, :pet_friendly, :facilities, :building_type, :description, :agent_id)
  end

end