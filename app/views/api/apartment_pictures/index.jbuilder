json.array! @apartment_pictures do |apartment_picture|
  json.partial! 'apartment_picture_template', apartment_picture: apartment_picture
end
