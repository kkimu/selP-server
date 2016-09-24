class UsersController < ApplicationController
  protect_from_forgery :except => [:share_jidori]

  def create
  end

  def new
  end

  def index
    @users = User.all
    render :json => @users
  end

  def share_jidori
    @user = User.find(params[:user_id])
    @jidori = @user.jidoris.build
    file_path = "public/img/#{Time.now.strftime('%Y%m%d%H%M%S')}.jpg"

    File.open(file_path, 'wb') do |f|
      f.write(params[:image_binary].try(:read))
    end

    result = @jidori.detects_face_and_campaign
    unless result[:face]
      render json: {post_link: "", campaign_id: "",
                    campaign_name: "", acquired_points: "",
                    total_points: total_points, code: 400, message: '顔が見つかりません'} and return
    end
    unless result[:campaign_id]
      render json: {post_link: "", campaign_id: "",
                    campaign_name: "", acquired_points: "",
                    total_points: total_points, code: 400, message: 'キャンペーンアイテムが見つかりません'} and return
    end

    @campaign = Campaign.find(result[:campaign_id])
    @jidori.campaign_id = @campaign.id
    @jidori.points = @campaign.base_points

    fb_token = ENV['FB_ACCESS_TOKEN'] # PublishActions権限のトークンが発行されしだい修正する
    begin
      fb_responce = @jidori.post_to_sns(fb_token), file_path)

      if fb_responce[:id].to_i > 0 && @jidori.save
        render json: {post_link: @jidori.post_url, campaign_id: @campaign.id,
                      campaign_name: @campaign.name, acquired_points: @campaign.base_points,
                      total_points: total_points, code: 200, message: '成功'} and return
      else
        render json: {post_link: "", campaign_id: "",
                      campaign_name: "", acquired_points: "",
                      total_points: total_points, code: 400, message: '保存失敗'} and return
      end
    rescue => e
      puts e.message
      render json: {post_link: "", campaign_id: "",
                    campaign_name: "", acquired_points: "",
                    total_points: total_points, code: 400, message: '保存失敗'} and return
    end
  end

  def total_points
    @user.jidoris.pluck(:points).inject(:+)
  end
end
