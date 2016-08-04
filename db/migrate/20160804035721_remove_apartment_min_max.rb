class RemoveApartmentMinMax < ActiveRecord::Migration[5.0]
  def change
    remove_column :apartments, :property_size_gross_max
    remove_column :apartments, :property_size_gross_min
  end
end
