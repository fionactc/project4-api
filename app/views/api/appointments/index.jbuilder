json.confirmed_upcoming do
  json.array! @confirmed_upcoming do |cu|
    json.merge! cu.attributes
    json.renter cu.renter
    json.agent cu.agent
    json.agent_rating cu.agent_rating
    json.renter_rating cu.renter_rating
  end
end

json.unconfirmed_upcoming do
  json.array! @unconfirmed_upcoming do |uu|
    json.merge! uu.attributes
    json.renter uu.renter
    json.agent uu.agent
    json.agent_rating uu.agent_rating
    json.renter_rating uu.renter_rating
  end
end

json.confirmed_past do
  json.array! @confirmed_past do |cp|
    json.merge! cp.attributes
    json.renter cp.renter
    json.agent cp.agent
    json.agent_rating cp.agent_rating
    json.renter_rating cp.renter_rating
  end
end

json.unconfirmed_past do
  json.array! @unconfirmed_past do |up|
    json.merge! up.attributes
    json.renter up.renter
    json.agent up.agent
    json.agent_rating up.agent_rating
    json.renter_rating up.renter_rating
  end
end