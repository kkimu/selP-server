class AddAttachmentImageToJidoris < ActiveRecord::Migration
  def self.up
    change_table :jidoris do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :jidoris, :image
  end
end
