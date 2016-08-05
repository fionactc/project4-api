class Api::ApartmentPicturesController < ApplicationController
  before_action :set_apartment_picture, only: [:show, :update, :destroy]

  def index
    @apartment_pictures = ApartmentPicture.includes(apartment: :agent).all
  end

  def show
  end

  def create
    @apartment_picture = ApartmentPicture.new(apartment_picture_params)
    if @apartment_picture.save
      render 'show'
    else
      render json: {errors: @apartment_picture.errors.messages }, status: 400
    end
  end

  def update
    @apartment_picture.assign_attributes(gallery_params)
    if @apartment_picture.save
      render 'show'
    else
      render json: {errors: @apartment_picture.errors.messages }, status: 400
    end
  end


  def destroy
    @apartment_picture.destroy

    head 200
  end

private

  def set_apartment_picture
    @apartment_picture = ApartmentPicture.includes(apartment: :agent).find_by_id(params[:id])
    if @apartment_picture.nil?
      render json: {message: "Cannot find arwork with ID #{params[:id]}"}
    end
  end

  def apartment_picture_params
    params.permit(:picture, :apartment)
  end
end
