class ChangeFacebookObjectIdColumnToJidoris < ActiveRecord::Migration[5.0]
  def up
    change_column :jidoris, :facebook_object_id, :string
  end

  def down
    change_column :jidoris, :facebook_object_id, :integer
  end
end
