class ChangeColumnToProducts < ActiveRecord::Migration[5.0]
  def up
    change_column :products, :like_points, :integer, default: 0
  end

  def down
    change_column :products, :like_points, :float
  end
end
