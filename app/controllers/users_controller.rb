class UsersController < ApplicationController

  skip_before_action :authenticate_request, only: [:create]
  before_action :find_users, only: [:index]
  before_action :find_entity, except: [:index, :create]

  def index
    render json: @library_users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(users_params.except(:type_user_id))

    email = User.find_by(email: users_params[:email])
    if email
      render json: { error: 'eamil already existy' }, status: :conflict
      return
    end

    if @current_user&.type_user_id == 1
      @user.type_user_id = users_params[:type_user_id]
    else
      @user.type_user_id = 3
    end

    if @user.save!
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update

    user_update = User.find_by(id: users_params[:id])
    if @current_user.type_user_id != 1 && user_update&.type_user_id != users_params[:type_user_id]
      render json: { error: 'unpermitted action' }, status: :forbidden
      return
    end

    if @user.update!(users_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def find_users
    @library_users = User.by_library(@current_library['id'])
  end

  def find_entity
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(
      :id, :name, :email, :cpf, :card_identity, :type_user_id, :library_id, :password, :password_confirmation 
    )
  end
end
