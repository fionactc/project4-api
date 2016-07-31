class CreateRenterRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :renter_ratings do |t|
      t.integer :rr_overall_star
      t.text    :rr_comment
      t.boolean :no_show
      t.boolean :spy

      t.integer :agent_id
      t.integer :renter_id
      t.integer :appointment_id

      t.timestamps
    end
  end
end
