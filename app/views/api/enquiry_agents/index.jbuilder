json.array! @matched_enquiries_agents do |enquiry|
  json.id enquiry.id
  json.is_blocked enquiry.is_blocked
  json.agent_id enquiry.agent_id
  json.chat_id enquiry.chat_id
  json.created_at enquiry.created_at
  json.updated_at enquiry.updated_at
  json.enquiry enquiry.enquiry
  json.renter enquiry.enquiry.renter
end




