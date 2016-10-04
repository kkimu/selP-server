require 'koala'

class Jidori < ApplicationRecord
  belongs_to :user
  belongs_to :campaign, required: false

  after_commit :check_face_and_campaign, on: :create

  has_attached_file :image,
                    styles: {midium: '300x300#', thumb: '100x100#'},
                    path: "/static/jidoris/#{DateTime.now.strftime('%Y%m%d%H%M%S')}-:style.:extension"
  validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png)

  def detects_face_and_campaign(file_name)
    #uri = URI.parse('http://localhost:5000/image/' + file_name)
    uri = URI.parse("http://#{ENV['CV_PORT_5000_TCP_ADDR']}:#{ENV['CV_PORT_5000_TCP_PORT']}/image/#{file_name}")
    http = Net::HTTP.new(uri.host, uri.port)
    res = http.start { |h| h.get(uri.request_uri) }
    JSON.parse(res.body) #{face:true, campaign_id:1}
  rescue => e
    p e.message
  end

  def post_to_sns(oauth_access_token, file_path)
    graph = Koala::Facebook::API.new(oauth_access_token)
    graph.put_picture(file_path)
  end

  private

  def check_face_and_campaign
    res_cv = detects_face_and_campaign(self.image_file_name)

    unless res_cv['face']
      self.errors.add(:base, '顔が見つかりません')
      raise ActiveRecord::RecordInvalid.new(self)
    end
    unless res_cv['product_path']
      self.errors.add(:base, 'キャンペーンアイテムが見つかりません')
      raise ActiveRecord::RecordInvalid.new(self)
    end

    detected_campaign = Campaign.find_by(file_name: res_cv['product_path'].chomp.split('/')[-1])
    self.update_columns({campaign_id: detected_campaign.id, points: detected_campaign.base_points})

    true
  end
end
