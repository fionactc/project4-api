class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    puts '----------------------'
    puts 'perform, message: '
    puts message
    puts '----------------------'
    # saved message is passed here
    # ActionCable.server.broadcast "chat_rooms_#{message.chat.id}_channel", message: render_message(message)
    ActionCable.server.broadcast "chat_rooms_#{message.chat.id}_channel", message: message
  end

  private

  def render_message(message)
    Api::MessagesController.render partial: 'api/messages/message', locals: {message: message}
  end
end