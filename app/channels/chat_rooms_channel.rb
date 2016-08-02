class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    # process data sent from the page
    # no need to check if chat room exist, default must exist in rails 5
    puts 'HELLOoOOOOOOOOOOO'
    puts current_user
    message = current_user.messages.create(body: data['message'], chat_id: data['chat_room_id'])
  end
end