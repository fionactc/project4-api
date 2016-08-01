class Api::RentersController < ApplicationController
  before_action :authenticate_renter!, except: [:index, :show]
  before_action :set_renter, only: [:show]

  def index
    @renters = Renter.includes(:enquiries).all
  end

  def show
  end

  def create
    @renter = current_renter.new(renter_params)
    if @renter.save
      render 'show'
    else
      render json: @renter.errors.messages, status: 400
    end
  end

  def update
    puts renter_params
    current_renter.assign_attributes(renter_params)
    if current_renter.save
      # render 'show'
      render json: {current_renter: current_renter, avatar: current_renter.avatar.url(:medium)}
    else
      render json: {errors: current_renter.errors.messages}, status: 400
    end
  end

  def destroy
    current_renter.destroy
  end

private

  def set_renter
    @renter = Renter.includes(:enquiries).find_by_id(params[:id])
    if @renter.nil?
      render json: {message: "Cannot find renter with ID #{params[:id]}"}
    end
  end

  # refer to schema
  def renter_params
    params.permit(:email, :name, :salutation, :first_name, :family_name, :mobile_number, :renter_avg_ratings, :birthday, :gender, :occupation, :pet, :english, :is_admin, :gen_vtoken, :is_verified)
  end
end
