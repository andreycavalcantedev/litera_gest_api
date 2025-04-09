class LibrariesController < ApplicationController

  def index
    @libraries = Library.all
    render json: @libraries 
  end

  def  show
    @library = Library.find(libraries_params[:id])
    render  json: @library
  end

  def create
    @library = Library.new(libraries_params)
    if @library.save
      render json: @library
    else
      render json: @library.errors, status: :unprocessable_entity
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

  def libraries_params
    params.require(:library).permit(
      :name, :phone, :whatsapp, :email,
      :opening_time, :closing_time,
      :cnpj, :instagram
    )
  end
end
