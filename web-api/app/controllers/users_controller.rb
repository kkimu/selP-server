class UsersController < ApplicationController
  def create
  end

  def show
    @user = User.find(params[:id])
    render 'show', formats: [:json], handlers: [:jbuilder], status: :ok
  end

  def index
    @users = User.all
    render json: {users: @users}, status: :ok
  end
end
