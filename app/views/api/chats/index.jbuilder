json.array! @chats do |chat|
  json.chat chat
  json.messages chat.messages
  json.renter chat.renter
  json.agent chat.agent
end