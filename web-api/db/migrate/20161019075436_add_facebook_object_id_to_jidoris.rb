class AddFacebookObjectIdToJidoris < ActiveRecord::Migration[5.0]
  def change
    add_column :jidoris, :facebook_object_id, :integer
  end
end
