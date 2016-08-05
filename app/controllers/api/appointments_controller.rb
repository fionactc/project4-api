class Api::AppointmentsController < ApplicationController
  before_action :authenticate_agent!, only: [:create, :destroy]
  before_action :authenticate_user!, only: [:index, :show, :update]
  before_action :set_appointment, only:  [:show, :update, :destroy]

  def index
    @appointments = Appointment.includes(:agent_rating, :renter_rating, :enquiry_agent).all
  end

  def show
  end

  def create
    # @appointment = Appointment.new(appointment_params)
    @appointment = current_agent.appointments.new(appointment_params)
    if @appointment.save
      render 'show'
    else
      render json: @appointment.errors.messages, status: 400
    end
  end

  def update
    @appointment.assign_attributes(appointment_params)
    if @appointment.save
      render 'show'
    else
      render json: {errors: @appointment.errors.messages}, status: 400
    end
  end

  def destroy
    @appointment.destroy
  end

private

  def set_appointment
    @appointment = Appointment.includes(:agent_rating, :renter_rating, :enquiry_agent).find_by_id(params[:id])
    if @appointment.nil?
      render json: {message: "Cannot find appointment with ID #{params[:id]}"}
    end
  end

  # refer to schema
  def appointment_params
    params.permit(:start_date, :end_date, :start_time, :end_time, :read, :agent_rating_id, :renter_rating_id, :enquiry_agent_id)
  end

end
