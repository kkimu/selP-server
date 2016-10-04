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

  def show_points
    @user = User.find(params[:id])
    render json: {points: @user.total_points, code: 200}
  end

  def show_history
    @user = User.find(params[:id])
    render json: {total_points: @user.total_points, jidoris: @user.jidoris, code:200}
  end
end
