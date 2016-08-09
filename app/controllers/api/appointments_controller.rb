class Api::AppointmentsController < ApplicationController
  before_action :authenticate_agent!, only: [:create]
  before_action :authenticate_user!, only: [:index, :show, :update]
  before_action :set_appointment, only:  [:show, :update]

  def index
    if (current_agent)
      @confirmed_upcoming = Appointment.includes(:renter, :agent, :renter_rating, :agent_rating).where(agent_id: current_agent.id).where(confirmed: true).where("end_time > ? ", Time.new)
      @unconfirmed_upcoming = Appointment.includes(:renter, :agent, :renter_rating, :agent_rating).where(agent_id: current_agent.id).where(confirmed: false).where("end_time >? ", Time.new)
      @confirmed_past = Appointment.includes(:renter, :agent, :renter_rating, :agent_rating).where(agent_id: current_agent.id).where(confirmed: true).where("end_time < ? ", Time.new)

    elsif (current_renter)
      @confirmed_upcoming = Appointment.includes(:agent, :renter, :renter_rating, :agent_rating).where(renter_id: current_renter.id).where(confirmed: true).where("end_time > ? ", Time.new)
      @unconfirmed_upcoming = Appointment.includes(:agent, :renter, :renter_rating, :agent_rating).where(renter_id: current_renter.id).where(confirmed: false).where("end_time >? ", Time.new)
      @confirmed_past = Appointment.includes(:agent, :renter, :renter_rating, :agent_rating).where(renter_id: current_renter.id).where(confirmed: true).where("end_time < ? ", Time.new)
      @unconfirmed_past = Appointment.includes(:agent, :renter, :renter_rating, :agent_rating).where(renter_id: current_renter.id).where(confirmed: false).where("end_time <? ", Time.new)
    end
  end

  def show
  end

  def create
    @message = current_agent.messages.create(
      chat_id: params[:chat_id],
      body: 'Viewing in ' + params[:location] + ' with ' + current_agent.id.to_s + ' on ' + params[:start_time],
      message_type: 'appointment',
      appointment_status: 'unconfirmed')
      @appointment = Appointment.new(start_time: params[:start_time], end_time: params[:end_time], renter_id: params[:renter_id], location: params[:location], message_id: @message.id)
      @appointment.update_attributes(agent_id: current_agent.id)
      if @appointment.save
        render json: @appointment
      else
        puts 'ERORROORORORORORO'
        puts @appointment.errors.messages
        render json: @appointment.errors.messages, status: 400
      end
  end

  def confirm
    @message = Message.find(params[:id])
    @appointment = @message.appointment
    @appointment.update_attributes(confirmed: true)
    if @appointment.save

      # create renter_ratings, agent_ratings
      # @renterRating = current_renter.renter_ratings.create(agent_id: @appointment.agent_id, appointment_id: @appointment)
      rRating = RenterRating.create(agent_id: @appointment.agent_id, renter_id: current_renter.id, appointment_id: @appointment.id)
      aRating = AgentRating.create(agent_id: @appointment.agent_id, renter_id: current_renter.id, appointment_id: @appointment.id)
      if aRating.save
        puts 'aRating is saved'
      else
        puts 'ERORROORORORORORO'
        puts aRating.errors.messages, status: 400
      end

      # create message
      @message.update_attributes(appointment_status: 'confirmed')
      @confirm_message = current_renter.messages.create(
        chat_id: @message.chat_id,
        body: 'I have confirmed our appointment on ' + @appointment.start_time + '.' ,
        message_type: 'text')
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
    @message = Message.find(params[:id])
    appointment = @message.appointment.destroy
    @message.update_attributes(appointment_status: 'cancelled')

    @destroy_message = current_user.messages.create(
      chat_id: @message.chat_id,
      body: 'I have cancelled our appointment on ' + appointment.start_time + ', ' + appointment.start_date + '.' ,
      message_type: 'text')
    if @destroy_message.save
      render json: @destroy_message
    else
      puts 'ERORROORORORORORO'
      puts @destroy_message.errors.messages, status: 400
    end
  end

private

  def set_appointment
    @appointment = Appointment.includes(:renter, :agent).find_by_id(params[:id])
    if @appointment.nil?
      render json: {message: "Cannot find appointment with ID #{params[:id]}"}
    end
  end

  # refer to schema
  def appointment_params
    params.permit(:start_time, :end_time, :renter_id, :location, :chat_id)
  end

end
