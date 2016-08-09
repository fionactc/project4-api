class Appointment < ApplicationRecord
  belongs_to :agent
  belongs_to :renter
  belongs_to :message
  has_one :renter_rating
  has_one :agent_rating
end
