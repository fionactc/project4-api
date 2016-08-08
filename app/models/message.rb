class Message < ApplicationRecord
  belongs_to  :chat
  belongs_to :imageable, polymorphic: true
  has_many :property_listings
  has_one :appointment

  def timestamp
  created_at.strftime('%H:%M:%S %d %B %Y')
  end
  validates :body, presence: true, length: {minimum: 2, maximum: 1000}
  after_create_commit { MessageBroadcastJob.perform_later(self) }

end
