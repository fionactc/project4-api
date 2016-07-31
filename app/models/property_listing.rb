class PropertyListing < ApplicationRecord
  has_one     :apartment
  belongs_to  :enquiry_agent
end
