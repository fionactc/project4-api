class AddColumnToRatings < ActiveRecord::Migration[5.0]
  def change
    add_column :renter_ratings, :done, :boolean, default: false
    add_column :agent_ratings, :done, :boolean, default: false
  end
end
