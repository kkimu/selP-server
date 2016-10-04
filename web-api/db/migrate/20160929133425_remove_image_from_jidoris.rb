class RemoveImageFromJidoris < ActiveRecord::Migration[5.0]
  def up
    remove_column :jidoris, :image
  end

  def down
    add_column :jidoris, :image, :string
  end

end
