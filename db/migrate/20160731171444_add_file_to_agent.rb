class AddFileToAgent < ActiveRecord::Migration[5.0]
  def change
    add_attachment :agents, :license_file
    add_attachment :agents, :company_logo
  end
end
