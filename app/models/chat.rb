class Chat < ApplicationRecord
  # belongs_to :enquiry_agent
  belongs_to :agent
  belongs_to :renter
  has_many   :messages, dependent: :destroy
  validates_uniqueness_of :agent_id, :scope => :renter_id
end
