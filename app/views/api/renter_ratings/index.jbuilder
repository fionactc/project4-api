json.array! @renter_ratings do |renter_rating|
  json.partial! 'renter_rating_template', renter_rating: renter_rating
end
