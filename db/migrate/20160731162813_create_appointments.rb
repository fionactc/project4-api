class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.date    :start_date
      t.date    :end_date
      t.time    :start_time
      t.time    :end_time
      t.boolean :read

      t.integer :agent_rating_id
      t.integer :renter_rating_id
      t.integer :enquiry_agent_id

      t.timestamps
    end
  end
end
