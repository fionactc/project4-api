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

    # definitely need chat_id
    @appointment = current_agent.appointments.new(appointment_params)
    if @appointment.save
      @message = current_agent.messages.create(
        chat_id: params[:chat_id],
        body: 'I have created a new appointment on ' + params[:start_time] + ', '+ params[:start_date] + ', please confirm.',
        message_type: 'appointment')
      # render 'show'
      render json: @appointment
    else
      render json: @appointment.errors.messages, status: 400
    end
  end

  def confirm
    # send back appointment_id
    @appointment = Appointment.find(params[:id]).update_attributes(confirmed: true)
    if @appointment.save
      chat = Chat.where(agent_id: @appointment.agent_id, renter_id: @appointment.renter_id)
      @message = current_renter.messages.create(
        chat_id: chat.id,
        body: 'I have confirmed our appointment on ' + params[:start_time] + ', ' + params[:start_date] '.',
        message_type: 'appointment')
      render json: @appointment
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
    params.permit(:start_date, :end_date, :start_time, :end_time, :read, :agent_rating_id, :renter_rating_id, :enquiry_agent_id, :chat_id)
  end

end
