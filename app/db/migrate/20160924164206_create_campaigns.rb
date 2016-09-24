class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :base_points
      t.text :description
      t.integer :sponsor_id
      t.string :image

      t.timestamps
    end
  end
end
