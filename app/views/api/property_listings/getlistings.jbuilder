json.array! @listings do |listing|
  json.id listing.id
  json.message_id listing.message_id
  json.agent_id listing.agent_id
  json.apartment listing.apartment
end