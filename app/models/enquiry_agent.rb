class EnquiryAgent < ApplicationRecord
  belongs_to  :enquiry
  belongs_to  :agent
  has_many    :property_listings
  has_one     :chat
  has_many    :appointments
end
