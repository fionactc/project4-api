class AddMessageidToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :message_id, :string
    remove_column :messages, :appointment_id, :string
    add_column :messages, :appointment_status, :string
  end
end
