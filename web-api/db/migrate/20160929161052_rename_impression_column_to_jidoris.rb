class RenameImpressionColumnToJidoris < ActiveRecord::Migration[5.0]
  def change
    rename_column :jidoris, :impression, :impressions
  end
end
