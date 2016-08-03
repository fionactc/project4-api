class ChangeDataTypeNumApartment < ActiveRecord::Migration[5.0]
  def change
    change_column :apartments, :bedroom_num, :string
    change_column :apartments, :bathroom_num, :string
    change_column :enquiries, :bedroom_num, :string
    change_column :enquiries, :bathroom_num, :string
  end
end
