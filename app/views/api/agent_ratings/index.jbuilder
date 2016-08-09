json.array! @agent_ratings do |agent_rating|
  json.partial! 'agent_rating_template', agent_rating: agent_rating
end
