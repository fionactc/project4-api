class AddRemarksToEnquiry < ActiveRecord::Migration[5.0]
  def change
    add_column :enquiries, :remarks, :text
  end
end
