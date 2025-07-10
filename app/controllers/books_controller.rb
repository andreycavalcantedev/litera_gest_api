class BooksController < ApplicationController

  before_action :find_books
  before_action :find_entity, except: %i[index create]
  before_action :verify_user, except: %i[index show]
  
  def index
    if params[:title].present?
      @library_books = @library_books.search_by_title(params[:title])
    end

    if params[:author].present?
      @library_books = @library_books.search_by_author(params[:author])
    end

    if params[:publisher_name].present?
      @library_books = @library_books.search_by_publisher(params[:publisher_name])
    end

    render json: @library_books
  end

  def show
    render json: @entity.as_json(include: %i[publisher author])
  end

  def create
    ActiveRecord::Base.transaction do
      @book = Book.new(book_params.except(:publisher, :author))

      if book_params[:publisher_id].nil?
        publisher = Publisher.create!({
          name: book_params[:publisher][:name],
          cnpj: book_params[:publisher][:cnpj],
          phone: book_params[:publisher][:phone],
          email: book_params[:publisher][:email],
          url: book_params[:publisher][:url]
        })
        @book.publisher_id = publisher.id
      end

      if book_params[:author_id].nil?
        author = Author.create!({
          name: book_params[:author][:name],
          birthdate: book_params[:author][:birthdate],
          death_date: book_params[:author][:death_date],
          url_image: book_params[:author][:url_image]
        })
        @book.author_id = author.id
      end

      @book.library_id = @current_library['id']

      @book.save!
    end

    render json: @book.as_json(include: %i[publisher author])
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update
    ActiveRecord::Base.transaction do 
      if book_params[:author_id] == @entity.author_id
        @entity.author.update!(book_params[:author])
      end
      if book_params[:publisher_id] == @entity.publisher_id
        @entity.publisher.update!(book_params[:publisher])
      end

      @entity.update!(book_params.except(:author, :publisher))
    end
    
    render json: @entity.as_json(include: %i[publisher author])
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def destroy
    @entity.destroy
  end

  private

  def verify_user
    return render json: { error: 'Unauthorized action' }, status: :unauthorized if @current_user.type_user_id == 3
  end

  def find_books
    @library_books = Book.by_library(@current_library['id'])
  end

  def find_entity
    @entity = Book.find(params[:id])
  rescue
    render json: { error: 'Not found' }, status: :not_found
  end

  def book_params
    params.require(:book).permit(
      :id, :title, :description, 
      :year_published, :gender, :isbn,
      :total_quantity, :quantity, 
      :author_id, :publisher_id,
      publisher: [
        :name, :cnpj,
        :phone, :email, 
        :url
      ], 
      author: [
        :name, :birthdate,
        :death_date, 
        :url_image
      ]
    )
  end

end
