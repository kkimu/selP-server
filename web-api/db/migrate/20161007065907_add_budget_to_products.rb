class AddBudgetToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :budget, :integer
  end
end
