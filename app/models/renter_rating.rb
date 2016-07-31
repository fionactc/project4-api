class RenterRating < ApplicationRecord
  belongs_to :agent
  belongs_to :renter
  belongs_to :appointment
end
