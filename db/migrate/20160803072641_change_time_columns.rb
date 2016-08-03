class ChangeTimeColumns < ActiveRecord::Migration[5.0]
  def change
    change_column :enquiries, :timeslot_1_time, :string
    change_column :enquiries, :timeslot_2_time, :string
  end
end
