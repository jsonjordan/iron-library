class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.includes(:user)
  end

  def index
    @books = Book.where(confirmed: true)
  end

  def search
    if params[:criteria]
      @books = Book.search_by_all(params[:criteria])
    end
  end

  def campus_index
    @books = Book.where(campus_id: params[:campu_id], confirmed: true)
  end

  def new
    @campus = Campus.find params[:campu_id]
    @book = @campus.books.new
  end

  def confirm
    @campus = Campus.find params[:campu_id]
    gb = GetBook.new(params[:book][:isbn])
    @book = gb.find

    unless @book.present?
      flash[:warning] = "Book not found"
      redirect_to new_campu_book_path(@campus)
    end

  end

  def create
    @book = Book.find params[:book][:book_id]
    @book.category = params[:book][:category]
    @book.campus_id = params[:campu_id]
    @book.confirmed = true
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
      format.html { redirect_to "/campus/#{book.campus.id}/books" }
      format.json { render json: { status: :ok } }
    end
  end

  private

  def set_campus
    @campus = Campus.find params[:campu_id]
  end
end
