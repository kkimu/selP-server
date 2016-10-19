class JidorisController < ApplicationController
  protect_from_forgery :except => [:create]

  def index
    @user = User.first
    render json: {jidoris: @user.jidoris}, status: :ok
  end

  # POST /jidoris
  def create
    @user = User.first
    @jidori = @user.jidoris.build(jidori_params)
    @jidori.save!

    res = @jidori.post_to_sns(@user.auth_token, @jidori.image.path)
    @jidori.update_columns(facebook_object_id: res['post_id'])

    render 'create', formats: [:json], handlers: [:jbuilder], status: :created
  rescue => e
    render json: {message: 'Error: ' + e.message}, status: :internal_server_error
  end

  private

  def jidori_params
    params.permit(:image)
  end
end
