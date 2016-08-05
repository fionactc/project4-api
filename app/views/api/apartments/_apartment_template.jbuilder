json.merge! apartment.attributes
json.apartment_pictures apartment.apartment_pictures[0].picture.url

json.apartment_pictures apartment.apartment_pictures  do |q|
  json.picture q.picture
end

