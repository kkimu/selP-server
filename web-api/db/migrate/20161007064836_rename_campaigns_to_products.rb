class RenameCampaignsToProducts < ActiveRecord::Migration[5.0]
  def change
    rename_table :campaigns, :products
  end
end
