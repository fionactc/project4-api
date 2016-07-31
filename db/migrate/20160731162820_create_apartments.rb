class CreateApartments < ActiveRecord::Migration[5.0]
  def change
    create_table :apartments do |t|
      t.string  :apt_name
      t.string  :street
      t.string  :area
      t.integer :property_size_gross_min
      t.integer :property_size_gross_max
      t.integer :property_size_net_min
      t.integer :property_size_net_max
      t.integer :price
      t.integer :bedroom_num
      t.integer :bathroom_num
      t.boolean :pet_friendly
      t.string  :facilities
      t.string  :building_type
      t.string  :description

      t.integer :agent_id

      t.timestamps
    end
  end
end
