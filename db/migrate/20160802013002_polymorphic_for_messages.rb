class PolymorphicForMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :imageable_id, :integer
    add_column :messages, :imageable_type, :string
    add_index :messages, [:imageable_type, :imageable_id]
  end
end
