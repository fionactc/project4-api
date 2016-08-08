class Apartment < ApplicationRecord
  belongs_to :agent
  has_many   :apartment_pictures
  has_many :property_listings
  # belongs_to :property_listing

end
