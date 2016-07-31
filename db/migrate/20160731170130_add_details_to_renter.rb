class AddDetailsToRenter < ActiveRecord::Migration[5.0]
  def change
    add_column :renters, :salutation, :string
    add_column :renters, :first_name, :string
    add_column :renters, :family_name, :string
    add_column :renters, :mobile_number, :string
    add_index  :renters, :mobile_number, :unique => true
    add_column :renters, :renter_avg_ratings, :float
    add_column :renters, :birthday, :date
    add_column :renters, :gender, :string
    add_column :renters, :occupation, :string
    add_column :renters, :pet, :boolean
    add_column :renters, :english, :boolean
    add_column :renters, :is_admin, :boolean
    add_column :renters, :gen_vtoken, :string
    add_column :renters, :is_verified, :boolean

  end
end
