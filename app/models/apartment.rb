class Apartment < ApplicationRecord
  belongs_to :agent
  has_many   :apartment_pictures
  belongs_to :property_listing

end
