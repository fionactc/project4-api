class AddAvatarToRenter < ActiveRecord::Migration[5.0]
  def change
    add_attachment :renters, :avatar
  end
end
