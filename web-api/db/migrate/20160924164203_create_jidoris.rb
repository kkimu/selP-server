class CreateJidoris < ActiveRecord::Migration[5.0]
  def change
    create_table :jidoris do |t|
      t.integer :product_id
      t.integer :user_id
      t.string :post_url
      t.integer :impression
      t.integer :points
      t.string :image

      t.timestamps
    end
  end
end
