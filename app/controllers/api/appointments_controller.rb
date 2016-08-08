class Api::AppointmentsController < ApplicationController
  before_action :authenticate_agent!, only: [:create]
  before_action :authenticate_user!, only: [:index, :show, :update]
  before_action :set_appointment, only:  [:show, :update, :destroy]

  def index
    # @appointments = Appointment.includes(:agent_rating, :renter_rating, :enquiry_agent).all
    # Person.where(name: 'Neil').or( Person.where(age: 27) )
    if (current_agent)
      @appointments = Appointment.includes(:agent, :renter).where(agent_id: current_agent.id)
    elsif (current_renter)
      @appointments = Appointment.includes(:agent, :renter).where(agent_id: current_renter.id)
    end
    # @appointments = Appointment.where(agent_id: current_agent.id).or(Appointment.where(renter_id: current_renter.id))
    # render json: @appointments
  end

  def show
  end

  def create
    # puts params[:start_time]
    # puts appointment_params
    @appointment = Appointment.new(appointment_params)
    @appointment.update_attributes(agent_id: current_agent.id)
    if @appointment.save

      chatId = Chat.where(renter_id: params[:renter_id], agent_id: current_agent.id)
      puts chatId
      @message = current_agent.messages.create(
        chat_id: params[:chat_id],
        body: 'I have created a new appointment on ' + params[:start_time] + ', '+ params[:start_date] + ', please confirm.',
        message_type: 'appointment')
      # render 'show'
      render json: @appointment
    # else
      # render json: @appointment.errors.messages, status: 400
    end
  end

  def confirm
    # send back appointment_id
    @appointment = Appointment.find(params[:id])
    @appointment.update_attributes(confirmed: true)
    if @appointment.save
      chat = Chat.where(agent_id: @appointment.agent_id, renter_id: @appointment.renter_id).first
      puts @appointment.agent_id
      puts @appointment.renter_id
      puts 'inside SAVEEE'
      puts 'inside SAVEEE'
      puts 'inside SAVEEE'
      puts chat.id
      @message = current_renter.messages.create(
        chat_id: chat.id,
        body: 'I have confirmed our appointment on ' + @appointment.start_time + ', ' + @appointment.start_date + '.' ,
        message_type: 'appointment')
      render json: @appointment
    end
    # else
    #   render json: @appointment.errors.messages, status: 400
    # end
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
    chat = Chat.where(agent_id: @appointment.agent_id, renter_id: @appointment.renter_id).first
    @message = current_user.messages.create(
      chat_id: chat.id,
      body: 'I have cancelled our appointment on ' + @appointment.start_time + ', ' + @appointment.start_date + '.' ,
      message_type: 'appointment')
    resp = @appointment.destroy
    render json: resp
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
    params.permit(:start_date, :start_time, :end_time, :renter_id, :location)
  end

end
