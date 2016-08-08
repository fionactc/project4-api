class ChangeDeviseProviderDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :renters, :provider, 'mobile_number'
    change_column_default :agents, :provider, 'mobile_number'
  end
end
