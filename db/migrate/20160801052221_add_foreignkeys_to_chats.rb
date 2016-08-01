class AddForeignkeysToChats < ActiveRecord::Migration[5.0]
  def change
    add_column :chats, :agent_id, :string
    add_column :chats, :renter_id, :string
  end
end
