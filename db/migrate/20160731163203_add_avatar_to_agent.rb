class AddAvatarToAgent < ActiveRecord::Migration[5.0]
  def change
    add_attachment :agents, :avatar
  end
end
