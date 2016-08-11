json.merge! apartment.attributes
json.apartment_pictures apartment.apartment_pictures do |apartment_picture|
json.merge! apartment_picture.attributes
json.url  apartment_picture.picture.url(:medium)
end


