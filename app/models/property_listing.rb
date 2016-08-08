class PropertyListing < ApplicationRecord

  belongs_to :apartment
  belongs_to :renter
  # belongs_to :enquiry
  belongs_to :agent
end
