class Agent < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :apartments
  has_many :enquiry_agents
  has_many :agent_ratings
  has_many :renter_ratings
  has_many :messages, as: :imageable
  has_many :chats

  has_attached_file :avatar, styles: {
    medium: "300x300>",
    thumb: "100x100>"
  }

  has_attached_file :license_file, styles: {
    medium: "300x300>",
    thumb: "100x100>"
  }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :license_file, content_type: { content_type: ["image/jpeg", "application/pdf", "image/png"] }

end
