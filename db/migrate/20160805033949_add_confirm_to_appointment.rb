class AddConfirmToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :confirmed, :boolean, default: false
  end
end
