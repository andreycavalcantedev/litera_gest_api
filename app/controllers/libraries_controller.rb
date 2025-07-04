class LibrariesController < ApplicationController

  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :find_entity, except: %i[index create]
  before_action :verify_user, except: %i[index show]

  def index
    @libraries = Library.all
    render json: @libraries 
  end

  def show
    render json: @library.as_json(include: :address)
  end

  def create
    if @current_user.library.present?
      return render json: { error: 'Unauthorized action' }, status: :unauthorized
    end

    @new_library = Library.new(library_params.except(:address))

    email = Library.find_by(email: library_params[:email])
    cnpj = Library.find_by(cnpj: library_params[:cnpj])
    phone = Library.find_by(phone: library_params[:phone])
    whatsapp = Library.find_by(whatsapp: library_params[:whatsapp])
    if email || cnpj || phone || whatsapp
      return render json: { error: 'informations already existy' }, status: :conflict
    end

    ActiveRecord::Base.transaction do
      address = Address.create!(library_params[:address])

      @new_library.save!
      @new_library.update!({ address_id: address.id })

      administrator_user = User.find(@current_user.id)
      administrator_user.update!({ library_id: @new_library.id })
    end

    render json: @new_library.as_json(include: :address)
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update
    ActiveRecord::Base.transaction do 
      @library.update!(library_params.except(:address))

      if @library.address.present?
        @library.address.update!(library_params[:address])
      end
    end

    render json: @library.as_json(include: :address)
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def destroy    
    @library.destroy
  end

  private

  def verify_user
    unless @current_user.type_user_id == 1
      return render json: { error: 'Unauthorized action' }, status: :unauthorized
    end
  end

  def find_entity
    @library = Library.find(params[:id])
  end

  def library_params
    params.require(:library).permit(
      :name, :phone, :whatsapp, :email,
      :opening_time, :closing_time,
      :cnpj, :instagram, address: [
        :country, :state, :city,
        :zipcode, :district, :street,
        :number, :complement
      ]
    )
  end
end
