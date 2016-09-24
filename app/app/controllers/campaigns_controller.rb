class CampaignsController < ApplicationController
  def index
    campaigns = Campaign.all
    render :json => campaigns
  end

  def new
  end
end
