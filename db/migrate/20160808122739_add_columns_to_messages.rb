class AddColumnsToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :property_listings, :message_id, :string
    add_column :messages, :appointment_id, :string
    add_column :messages, :listing_title, :string
  end
end
