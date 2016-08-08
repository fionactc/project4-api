class ChangeApartmentsAndEnquiriesSchema < ActiveRecord::Migration[5.0]
  def change
    remove_column :apartments, :building_type
    remove_column :enquiries, :building_type
    add_column :apartments, :walkup, :boolean
    add_column :apartments, :open_kitchen, :boolean

    add_column :enquiries, :walkup, :boolean
    add_column :enquiries, :open_kitchen, :boolean
    add_column :enquiries, :pet_friendly, :boolean
  end
end
