json.array! @appointments do |appointment|
  json.partial! 'appointment_template', appointment: appointment
end
