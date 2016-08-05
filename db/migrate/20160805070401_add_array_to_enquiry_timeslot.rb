class AddArrayToEnquiryTimeslot < ActiveRecord::Migration[5.0]
  def change
  remove_column  :enquiries, :timeslot, :string
  add_column :enquiries, :timeslot, :string, array: true
  end
end
