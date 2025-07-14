class UsersController < ApplicationController

  skip_before_action :authenticate_request, only: [:create]
  before_action :find_users, only: :index
  before_action :find_entity, except: %i[index create create_collaborator]
  before_action :verify_user, except: %i[index create]
  before_action :verify_admin, only: %i[index create_collaborator]

  def index
    render json: @library_users
  end

  def show
    render json: @user.as_json(include: [:library, :address] )
  end

  def create
    if User.exists?(email: users_params[:email])
      render json: { error: 'Email already exists' }, status: :conflict
      return
    end

    @user = User.new(users_params.except(:type_user_id, :address))
    @user.type_user_id = 3

    if @user.save
      render json: @user.as_json(include: :address), status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create_collaborator
    ActiveRecord::Base.transaction do
      address = Address.create!(users_params[:address])

      @collaborator = User.new(users_params.except(:address))
      @collaborator.library_id = @current_library.id
      @collaborator.address_id = address.id

      @collaborator.save!
    end

    render json: @collaborator.as_json(include: [:library, :address]), status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update
    begin
      ActiveRecord::Base.transaction do
        @user.update!(users_params.except(:address, :type_user_id))

        unless @user.type_user_id == 3 
          address = users_params[:address]
          @user.address.update!({
                                  country: address[:country],
                                  state: address[:state],
                                  city: address[:city],
                                  zipcode: address[:zipcode],
                                  district: address[:district],
                                  street: address[:street],
                                  number: address[:number],
                                  complement: address[:complement]
                               })
        end
      end

      if @user.type_user_id != 3
        render json: @user.as_json(include: :address), status: :ok
      else
        render json: @user, staus: :ok
      end
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def find_users
    if @current_user.type_user_id == 2
      @library_users = User.by_library(@current_library['id'])
    else
      @library_users = User.all
    end
  end

  def find_entity
    @user = User.find(params[:id])
  end

  def verify_user
    return render json: { error: 'Unauthorized action' }, status: :unauthorized if @current_user.type_user_id != 1 && params[:id].to_i != @current_user.id
  end

  def verify_admin
    if @current_user.type_user_id != 1
      return render json: { error: 'Unauthorized action' }
    end
  end

  def users_params
    params.require(:user).permit(
      :id, :name, :email, :cpf, 
      :card_identity, :type_user_id, 
      :password, :password_confirmation, 
      address: [
        :country, :state, :city,
        :zipcode, :district, :street,
        :number, :complement
      ]
    )
  end
end
