json.array! @appointments do |appointment|
  json.appointment appointment
  json.renter appointment.renter
  json.agent appointment.agent
end