class Api::ApartmentsController < ApplicationController
  before_action :authenticate_agent!, except: [:index, :show]
  before_action :set_apartment, only:  [:show, :update]
  before_action :set_apartment_pictures, only: [:create]

  def index
    @apartments = current_agent.apartments
    # render json: @apartments
  end

  def show
  end

  def create
    @apartment = current_agent.apartments.new(apartment_params)
    if @apartment.save
      @pictures.each do |key, value|
        ApartmentPicture.create(picture: value, apartment_id: @apartment.id)
      end
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

  def set_apartment_pictures
    @pictures = params[:files] if params[:files].present?
  end

  # refer to schema
  def apartment_params
    params.require(:apartment).permit(:apt_name, :street, :area, :property_size_gross, :property_size_net, :price, :bedroom_num, :bathroom_num, :pet_friendly, :facilities, :building_type, :description, :agent_id)
  end
end