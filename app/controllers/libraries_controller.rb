class LibrariesController < ApplicationController

  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :find_entity, except: [:index, :create]
  before_action :verify_user, only: [:create, :update, :destroy]

  def index
    @libraries = Library.all
    render json: @libraries 
  end

  def  show
    render  json: @library
  end

  def create

    @new_library = Library.new(libraries_params)

    email = Library.find_by(email: libraries_params[:email])
    cnpj = Library.find_by(cnpj: libraries_params[:cnpj])
    phone = Library.find_by(phone: libraries_params[:phone])
    whatsapp = Library.find_by(whatsapp: libraries_params[:whatsapp])
    if email || cnpj || phone || whatsapp
      return render json: { error: 'informations already existy' }, status: :conflict
    end

    if @new_library.save!

      administrator_user = User.find(@current_user.id)
      administrator_user.update!({ library_id: @new_library.id })

      render json: @new_library
    else
      render json: @new_library.errors, status: :unprocessable_entity
    end
  end

  def update
    if @library.update(libraries_params)
      render json: @library
    else
      render json: @library.errors, status: :unprocessable_entity
    end
  end

  def destroy    
    @library.destroy
  end

  private

  def verify_user
    unless @current_user.type_user_id == 1
      return render json: { erros: 'user unauthorized action' }, status: :unauthorized
    end
  end

  def find_entity
    @library = Library.find(params[:id])
  end

  def libraries_params
    params.require(:library).permit(
      :name, :phone, :whatsapp, :email,
      :opening_time, :closing_time,
      :cnpj, :instagram
    )
  end
end
