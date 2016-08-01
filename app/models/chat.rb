class Chat < ApplicationRecord
  belongs_to :enquiry_agent
  belongs_to :agent
  belongs_to :renter
  has_many   :messages
end
