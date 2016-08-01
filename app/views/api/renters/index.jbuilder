json.array! @renters do |renter|
  json.partial! 'renter_template', renter: renter

end
