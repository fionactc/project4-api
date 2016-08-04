class PropertyListing < ApplicationRecord

  has_one     :apartment
  belongs_to :renter
  belongs_to :enquiry
  belongs_to :agent
end
