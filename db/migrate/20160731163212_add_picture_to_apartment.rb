class AddPictureToApartment < ActiveRecord::Migration[5.0]
  def change
    add_attachment :apartment_pictures, :picture
  end
end
