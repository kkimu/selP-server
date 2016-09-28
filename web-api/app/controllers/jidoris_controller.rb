class JidorisController < ApplicationController
  def index
    jidoris = Jidori.all
    render :json => jidoris
  end

  def new
  end
end
