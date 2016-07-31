class AddDetailsToAgent < ActiveRecord::Migration[5.0]
  def change
    add_column :agents, :salutation, :string
    add_column :agents, :first_name, :string
    add_column :agents, :family_name, :string
    add_column :agents, :mobile_number, :string
    add_index  :agents, :mobile_number, :unique => true
    add_column :agents, :agent_avg_ratings, :float
    add_column :agents, :area, :string
    add_column :agents, :website, :string
    add_column :agents, :description, :text
    add_column :agents, :license_num, :string
    add_index  :agents, :license_num, :unique => true
    add_column :agents, :company_website, :string
    add_column :agents, :company_license_num, :string
    add_index  :agents, :company_license_num, :unique => true
    add_column :agents, :branch_address, :string
    add_column :agents, :branch_phone, :string
    add_column :agents, :branch_fax, :string
    add_column :agents, :gen_vtoken, :string
    add_column :agents, :is_verified, :boolean
  end
end
