class Api::ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chats = Chat.all
  end

  def new
    @chat = Chat.new
  end

  def create
    puts '-----------------'
    puts current_user.class
    puts '-----------------'
    @chat = current_user.chats.create(chat_params)
    puts @chat.title
    if @chat.save
      flash[:success] = 'Chat room added!'
      redirect_to api_chats_path
    else
      render json: {errors: @chat.errors.messages}
      # puts 'errorrrrrrrrrrr'
      # render 'new'
    end
  end

  def show
    @chatroom = Chat.includes(:messages).find_by(id: params[:id])
    # @message = Message.new
  end

  # receive a renter id, return/create a chatroom between renter and current_agent
  def findChat
    @chat = Chat.where(renter_id: params[:id], agent_id: current_agent.id).first_or_create()
    # insert chat_id to the related enquiry_agent
    enquiryAgent = EnquiryAgent.where(enquiry_id: params[:enquiryId], agent_id: current_agent.id)
    # enquiryAgents.each do |enquiryAgent|
      enquiryAgent.first.update_attributes(chat_id: @chat.id)
    # end
    # update_attributes(chat_id: @chat.id)
    @chatroom = Chat.includes(:messages).find_by(id: @chat.id)
  end

  private

  def chat_params
    params.require(:chat).permit(:title)
  end
end
