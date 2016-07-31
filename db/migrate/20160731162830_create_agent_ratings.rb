class CreateAgentRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :agent_ratings do |t|
      t.integer :ar_overall_star
      t.text    :ar_commment

      t.integer :agent_id
      t.integer :renter_id
      t.integer :appointment_id

      t.timestamps
    end
  end
end
