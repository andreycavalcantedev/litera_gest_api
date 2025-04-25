class LibrariesController < ApplicationController

  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :find_entity, except: [:index, :create]

  def index
    @libraries = Library.all
    render json: @libraries 
  end

  def  show
    render  json: @library
  end

  def create
    if @current_user.type_user_id = 1
      @new_library = Library.new(libraries_params)

      email = Library.find_by(email: libraries_params[:email])
      cnpj = Library.find_by(cnpj: libraries_params[:cnpj])
      phone = Library.find_by(phone: libraries_params[:phone])
      whatsapp = Library.find_by(whatsapp: libraries_params[:whatsapp])
      if email || cnpj || phone || whatsapp
        return render json: { error: 'informations already existy' }, status: :conflict
      end
  
      if @new_library.save!
        render json: @new_library
      else
        render json: @new_library.errors, status: :unprocessable_entity
      end
    else
      return render json: { error: 'user unauthorized action' }, status: :unauthorized
    end
  end

  def update
    @library = Library.find(params[:id])
    if @library.update(libraries_params)
      render json: @library
    else
      render json: @library.errors, status: :unprocessable_entity
    end
  end

  def destroy    
    @library = Library.find(params[:id])
    @library.destroy
  end

  private

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
