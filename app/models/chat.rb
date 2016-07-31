class Chat < ApplicationRecord
  belongs_to :enquiry_agent
  has_many   :messages
end
