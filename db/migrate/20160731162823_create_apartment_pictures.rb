class CreateApartmentPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :apartment_pictures do |t|
      t.integer :apartment_id

      t.timestamps
    end
  end
end
