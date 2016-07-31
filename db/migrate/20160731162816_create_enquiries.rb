class CreateEnquiries < ActiveRecord::Migration[5.0]
  def change
    create_table :enquiries do |t|
      t.string  :region
      t.string  :area
      t.integer :bedroom_num
      t.integer :bathroom_num
      t.integer :property_size_min
      t.integer :property_size_max
      t.integer :price_min
      t.integer :price_max
      t.string  :building_type
      t.string  :timeslot_1_date
      t.time    :timeslot_1_time
      t.string  :timeslot_2_date
      t.time    :timeslot_2_time
      t.boolean :archived

      t.integer :renter_id

      t.timestamps
    end
  end
end
