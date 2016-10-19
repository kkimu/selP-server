require 'koala'

class Jidori < ApplicationRecord
  belongs_to :user
  belongs_to :product, required: false

  after_commit :check_face_and_product, on: :create

  # For PaperClip
  has_attached_file :image,
                    styles: {original: '1080x1080>'},
                    path: '/static/jidoris/:hash-:style.:extension'

  validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png)
  validates_attachment :image,
                       presence: true,
                       less_than: 5.megabytes


  def detect_face_and_product(file_name)
    #uri = URI.parse('http://localhost:5000/image/' + file_name)
    uri = URI.parse("http://#{ENV['CV_PORT_5000_TCP_ADDR']}:#{ENV['CV_PORT_5000_TCP_PORT']}/image/#{file_name}")
    http = Net::HTTP.new(uri.host, uri.port)
    res = http.start { |h| h.get(uri.request_uri) }
    JSON.parse(res.body) #{face:true, product_id:1}
  end

  def post_to_sns(oauth_access_token, file_path)
    graph = Koala::Facebook::API.new(oauth_access_token)
    graph.put_picture(file_path)
  end

  private

  def check_face_and_product
    res_cv = detect_face_and_product(self.image_file_name)
    unless res_cv
      self.errors.add(:base, 'CVサーバからの応答が空です')
      raise ActiveRecord::RecordInvalid.new(self)
    end
    unless res_cv['face']
      self.errors.add(:base, '顔が見つかりません')
      raise ActiveRecord::RecordInvalid.new(self)
    end
    unless res_cv['product_path']
      self.errors.add(:base, '対象商品が見つかりません')
      raise ActiveRecord::RecordInvalid.new(self)
    end

    detected_product = Product.find_by(image_file_name: File.basename(res_cv['product_path']))
    self.update_columns(product_id: detected_product.id,
                        points: detected_product.base_points,
                        image_file_name: File.basename(self.image.path))

    true
  end
end