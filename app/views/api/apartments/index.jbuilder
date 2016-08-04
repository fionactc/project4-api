  json.array! @apartments do |apartment|
    json.id apartment.id
    json.area apartment.area
    json.checked false
  end
