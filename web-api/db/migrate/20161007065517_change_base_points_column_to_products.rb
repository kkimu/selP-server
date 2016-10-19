class ChangeBasePointsColumnToProducts < ActiveRecord::Migration[5.0]
  def up
    change_column :products, :base_points, :integer, default: 0
  end

  def down
    change_column :products, :base_points, :integer
  end
end
