  json.array! @apartments do |apartment|
    json.partial! 'apartment_template', apartment: apartment
    json.checked false
  end
