class BooksController < ApplicationController

  def show
    @book = Book.find params[:id]
  end

  def index
    @books = Book.all
  end

  def campus_index
    @books = Book.where(campus_id: params[:campu_id])
  end

  def new
    @campus = Campus.find params[:campu_id]
    @book = @campus.books.new
  end

  def confirm
    @campus = Campus.find params[:campu_id]
    get_book(params[:book][:isbn])

    if !@book.present?
      flash[:warning] = "Book not found"
      redirect_to new_campu_book_path(@campus)
    end

    flash[:book] = @book

  end

  def create
    @campus = Campus.find params[:campu_id]
    @book = @campus.books.new flash[:book]
    if @book.save
      flash[:notice] = "Book added!"
      redirect_to "/campus/#{params[:campu_id]}/books"
    else
      render :new
    end
  end

  def destroy
    book = Book.find params[:id]
    book.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: { status: :ok } }
    end
  end

  private

  def set_campus
    @campus = Campus.find params[:campu_id]
  end

  def get_book isbn
    response = HTTParty.get("http://isbndb.com/api/v2/json/#{ENV["isbndb_key"]}/book/#{isbn}")

      r = JSON.parse(response)
    unless r["error"]
      data = r["data"].first
      @book = Book.new(isbn: isbn,
                       title: data["title_long"],
                       author: data["author_data"].first["name"],
                       summary: data["summary"],
                       data: r)
    end
  end

end
