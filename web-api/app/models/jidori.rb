require 'koala'

class Jidori < ApplicationRecord
  belongs_to :user
  belongs_to :campaign

  def detects_face_and_campaign(file_path)
    #uri = URI.parse('http://' + ENV['IMAGE_ENGINE_PORT_5000_TCP_ADDR'] + ':' + ENV['IMAGE_ENGINE_PORT_5000_TCP_PORT'] + '/image/' + file_path.chomp.split('/')[-1])
    uri = URI.parse('http://' + ENV['CV_PORT_5000_TCP_ADDR'] + ':' + ENV['CV_PORT_5000_TCP_PORT'] + '/image/book.jpg')
    http = Net::HTTP.new(uri.host, uri.port)
    res = http.start { |h|
      h.get(uri.request_uri)
    }
    #{face:true, campaign_id:1}
    JSON.parse(res.body)
  end

  def post_to_sns(oauth_access_token, file_path)
    @graph = Koala::Facebook::API.new(oauth_access_token)
    @graph.put_picture(file_path)
  end
end
