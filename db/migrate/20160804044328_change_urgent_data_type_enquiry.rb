class ChangeUrgentDataTypeEnquiry < ActiveRecord::Migration[5.0]
  def change
    change_column :enquiries, :urgent, :string
  end
end
