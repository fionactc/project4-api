class Message < ApplicationRecord
  belongs_to  :chat
  belongs_to :imageable, polymorphic: true
  # belongs_to  :agent
  # belongs_to  :renter

  # formatting created timestamp
  def timestamp
  created_at.strftime('%H:%M:%S %d %B %Y')
  end
  validates :body, presence: true, length: {minimum: 2, maximum: 1000}
  after_create_commit { MessageBroadcastJob.perform_later(self) }

end
