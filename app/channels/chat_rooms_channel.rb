class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    stop_all_streams
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    # process data sent from the page
    # no need to check if chat room exist, default must exist in rails 5
    puts 'inside send_message create'
    puts '--------------------------------'
    puts '--------------------------------'
    puts '--------------------------------'
    puts '--------------------------------'
    message = get_current_user(data).messages.create(body: data['message'], chat_id: data['chat_room_id'], message_type: 'text')
    puts message
  end

  def get_current_user(data)
    if verified_user = Renter.find_by(uid: data["uid"])
      verified_user
    elsif verified_user = Agent.find_by(uid: data["uid"])
      verified_user
    end
  end

  def send_listing(data)
    puts data['message']
    ActionCable.server.broadcast "chat_rooms_#{data['chat_room_id']}_channel", message: data['message']
  end
end