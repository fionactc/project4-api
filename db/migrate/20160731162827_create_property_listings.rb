class CreatePropertyListings < ActiveRecord::Migration[5.0]
  def change
    create_table :property_listings do |t|
      t.boolean :like

      t.integer :apartment_id
      t.integer :enquiry_agent_id

      t.timestamps
    end
  end
end
