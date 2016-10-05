class ChangeImpressionsToJidoris < ActiveRecord::Migration[5.0]
  def up
    change_column :jidoris, :impressions, :float, default: 0
  end

  def down
    change_column :jidoris, :impressions, :integer
  end
end
