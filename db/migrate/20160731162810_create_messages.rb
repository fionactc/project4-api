class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text    :body

      t.integer :chat_id
      t.integer :agent_id
      t.integer :renter_id

      t.timestamps
    end
  end
end
