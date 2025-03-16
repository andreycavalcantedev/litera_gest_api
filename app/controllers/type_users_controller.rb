class TypeUsersController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  def index
    @type_users = TypeUser.all
    render json: @type_users
  end

  def show
    @type_user = TypeUser.find(params[:id])
    render json: @type_user
  end

  def create
    @type_user = TypeUser.new(type_users_params)
    if @type_user.save!
      render json: @type_user
    else
      render json: @type_user.errors, status: :unprocessable_entity
    end
  end

  def update
    @type_user = TypeUser.find(params[:id])
    if @type_user.update!(type_users_params)
      render json: @type_user
    else
      render json: @type_user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @type_user = TypeUser.find(params[:id])
    @type_user.destroy
  end

  private

  def type_users_params
    params.require(:type_user).permit(:id, :role)
  end
end
