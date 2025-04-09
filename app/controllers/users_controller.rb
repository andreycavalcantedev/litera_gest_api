class UsersController < ApplicationController

  skip_before_action :authenticate_request, only: [:create]

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(users_params)
    if @user.save!
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update!(users_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private

  def users_params
    params.require(:user).permit(
      :id, :name, :email, :cpf, :card_identity, :type_user_id, :library_id, :password, 
    )
  end
end
