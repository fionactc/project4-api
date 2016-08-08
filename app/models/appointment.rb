class Appointment < ApplicationRecord
  # belongs_to :enquiry_agent
  # has_one    :agent_rating
  # has_one    :renter_rating
  belongs_to :agent
  belongs_to :renter
  # belongs_to :rating
end
