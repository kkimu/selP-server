class Product < ApplicationRecord
  has_many :jidoris
  belongs_to :sponsor

  after_commit :update_file_name, on: :create

  # For PaperClip
  has_attached_file :image,
                    styles: {original: '1080x1080>'},
                    path: '/static/products/:hash.:extension'

  validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png)
  validates_attachment :image,
                       presence: true,
                       less_than: 5.megabytes

  private

  def update_file_name
    self.update_columns(image_file_name: File.basename(self.image.path))
  end
end
