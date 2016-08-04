class ApartmentSize < ActiveRecord::Migration[5.0]
  def change
    remove_column :apartments, :property_size_net_max
    remove_column :apartments, :property_size_net_min
    remove_column :apartments, :facilities
    add_column :apartments, :property_size_net, :integer
    add_column :apartments, :property_size_gross, :integer
  end
end
