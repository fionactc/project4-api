class Renter < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable,
          :omniauthable, :authentication_keys => [:mobile_number]
  include DeviseTokenAuth::Concerns::User

  has_many :enquiries
  has_many :agent_ratings
  has_many :renter_ratings
  has_many :messages, as: :imageable
  has_many :chats
  has_many :property_listings
  has_one  :appointment

  has_attached_file :avatar, styles: {
    medium: "300x300>",
    thumb: "100x100>"
  }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :mobile_number, :presence => true, uniqueness: true
  validates :password, confirmation: true

  # devise
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["mobile_number = :value", { :value => login }]).first
    elsif conditions.has_key?(:mobile_number)
      where(conditions.to_h).first
    end
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.mobile_number
  end
end
