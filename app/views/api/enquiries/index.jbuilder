json.array! @enquiries do |enquiry|
  json.partial! 'enquiry_template', enquiry: enquiry
end
