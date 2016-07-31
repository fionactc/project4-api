class Enquiry < ApplicationRecord
  belongs_to  :renter
  has_many    :enquiry_agents
end
