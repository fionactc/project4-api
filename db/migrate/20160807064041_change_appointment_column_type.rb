class ChangeAppointmentColumnType < ActiveRecord::Migration[5.0]
  def change
    change_column :appointments, :start_date, :string
    change_column :appointments, :start_time, :string
    change_column :appointments, :end_time, :string
  end
end
