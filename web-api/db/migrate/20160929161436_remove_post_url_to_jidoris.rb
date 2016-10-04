class RemovePostUrlToJidoris < ActiveRecord::Migration[5.0]
  def change
    remove_column :jidoris, :post_url, :string
  end
end
