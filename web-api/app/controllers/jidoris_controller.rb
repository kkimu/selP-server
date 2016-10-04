class JidorisController < ApplicationController
  protect_from_forgery :except => [:create]

  def index
    jidoris = Jidori.all
    render json: jidoris, status: :ok
  end

  # POST /users/:user_id/jidoris
  def create
    @user = User.find(params[:user_id])
    @jidori = Jidori.new(jidori_params)
    @jidori.save!
    @detected_campaign = Campaign.find(@jidori.campaign_id)

    fb_token = @jidori.user.auth_token
    @jidori.post_to_sns(fb_token, @jidori.image.path)

    render 'create', formats: [:json], handlers: [:jbuilder], status: :created
  rescue => e
    render json: {message: 'Error: ' + e.message}, status: :internal_server_error
  end

  private

  def jidori_params
    params.permit(:user_id, :image)
  end
end
