class AddFilePathToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :file_path, :string
  end
end
