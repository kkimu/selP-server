class AddColumnToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :file_name, :string
  end
end
