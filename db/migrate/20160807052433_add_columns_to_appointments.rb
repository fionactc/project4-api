class AddColumnsToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :renter_id, :string
    add_column :appointments, :agent_id, :string
    add_column :appointments, :location, :string
    remove_column :appointments, :end_date
    remove_column :appointments, :read
  end
end
