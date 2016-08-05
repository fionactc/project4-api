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
    message = current_user.messages.create(body: data['message'], chat_id: data['chat_room_id'], message_type: 'text')
  end

  def send_listing(data)
    puts data['message']
    ActionCable.server.broadcast "chat_rooms_#{data['chat_room_id']}_channel", message: data['message']
  end
end