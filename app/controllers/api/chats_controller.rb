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
    @chat = Chat.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  private

  def chat_params
    params.require(:chat).permit(:title)
  end
end
