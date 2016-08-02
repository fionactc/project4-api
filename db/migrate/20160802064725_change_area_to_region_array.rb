class ChangeAreaToRegionArray < ActiveRecord::Migration[5.0]
  def change
    remove_column :agents, :area
    add_column :agents, :regions, :string, array: true
    add_index :agents, :regions
  end
end
