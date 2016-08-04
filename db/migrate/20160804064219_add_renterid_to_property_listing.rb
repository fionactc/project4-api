class AddRenteridToPropertyListing < ActiveRecord::Migration[5.0]
  def change
    add_column :property_listings, :renter_id, :string
    add_column :property_listings, :agent_id, :string
    add_column :property_listings, :enquiry_id, :string
  end
end
