class ChangeColumnToJidoris < ActiveRecord::Migration[5.0]
  def up
    change_column :jidoris, :points, :float, default: 0
  end

  def down
    change_column :jidoris, :points, :integer
  end
end
