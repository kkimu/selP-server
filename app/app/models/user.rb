class User < ApplicationRecord
  has_many :jidoris
  mount_uploader :image, JidoriPictureUploader
end
