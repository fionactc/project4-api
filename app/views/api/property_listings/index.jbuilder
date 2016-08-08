
json.array! @property_listings do |listing|
  json.agent listing[0].attributes
  json.properties listing[1] do |apartment|
    json.id apartment.apartment.id
    json.apt_name apartment.apartment.apt_name
    json.street apartment.apartment.street
    json.area apartment.apartment.area
    json.price apartment.apartment.price
    json.bedroom_num apartment.apartment.bedroom_num
    json.bathroom_num apartment.apartment.bathroom_num
    json.pet_friendly apartment.apartment.pet_friendly
    json.building_type apartment.apartment.building_type
    json.description apartment.apartment.description
    json.agent_id apartment.apartment.agent_id
    json.created_at apartment.apartment.created_at
    json.updated_at apartment.apartment.updated_at
    json.property_size_net apartment.apartment.property_size_net
    json.property_size_gross apartment.apartment.property_size_gross
  end
end
