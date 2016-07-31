class CreateEnquiryAgents < ActiveRecord::Migration[5.0]
  def change
    create_table :enquiry_agents do |t|
      t.boolean :is_blocked

      t.integer :agent_id
      t.integer :enquiry_id
      t.integer :chat_id

      t.timestamps
    end
  end
end
