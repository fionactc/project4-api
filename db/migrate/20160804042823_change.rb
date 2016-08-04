class Change < ActiveRecord::Migration[5.0]
  def change
    remove_column :enquiries, :timeslot_1_date
    remove_column :enquiries, :timeslot_1_time
    remove_column :enquiries, :timeslot_2_date
    remove_column :enquiries, :timeslot_2_time
    add_column  :enquiries, :available_days, :string, array: true
    add_column  :enquiries, :timeslot, :string
  end
end
