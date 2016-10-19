class AddColumnToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :like_points, :float
  end
end
