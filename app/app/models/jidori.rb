require 'koala'

class Jidori < ApplicationRecord
  belongs_to :user
  belongs_to :campaign

  def detects_face_and_campaign(file_path)
    uri = URI.parse('https://hogehoge/image/' + file_path)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    res = https.start {
      https.get(uri.request_uri)
    }
    #{face:true, campaign_id:1}
    JSON.parse(res.body)
  end

  def post_to_sns(oauth_access_token, file_path)
    @graph = Koala::Facebook::API.new(oauth_access_token)
    @graph.put_picture(file_path)
  end
end
