class Message < ApplicationRecord
  belongs_to  :chat
  belongs_to  :agent
  belongs_to  :renter
end
