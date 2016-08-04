class AddMoveInDateToEnquiry < ActiveRecord::Migration[5.0]
  def change
    add_column :enquiries, :urgent, :boolean
    add_column :enquiries, :movein_date, :date

  end
end
