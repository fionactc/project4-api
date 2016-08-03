class AddAreasArrayToEnquiry < ActiveRecord::Migration[5.0]
  def change
    remove_column :enquiries, :area
    add_column :enquiries, :areas, :string, array: true
    add_index :enquiries, :areas
    rename_column :agents, :regions, :areas
  end
end
