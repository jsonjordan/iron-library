class BooksController < ApplicationController

  def show
    @book = Book.find params[:id]
  end

  def index
    @books = Book.where(confirmed: true)
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
    get_book(params[:book][:isbn])

    if @book.present?
      @book.save
    else
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

  def get_book isbn
    response = HTTParty.get("http://isbndb.com/api/v2/json/#{ENV["isbndb_key"]}/book/#{isbn}")

    response2 = HTTParty.get("http://www.goodreads.com/search/index.xml",
    :query => { :q => isbn,
                :key => ENV["goodreads_key"],
                :field => 'isbn' })

    open_lib_pic = HTTParty.get("http://covers.openlibrary.org/b/isbn/#{isbn}-M.jpg?default=false")

    r = JSON.parse(response)

    good_reads = response2["GoodreadsResponse"]["search"]["results"]["work"]

    if r["error"]
      isbndb = ""
    else
      isbndb = r["data"].first["summary"]
    end

    if !good_reads["best_book"]["image_url"].match(/nophoto/).present?
      pic_url = good_reads["best_book"]["image_url"].gsub(/(?<=[0-9])m/, "l")
    elsif open_lib_pic.code == 200
      pic_url = "http://covers.openlibrary.org/b/isbn/#{isbn}-M.jpg"
    else
      pic_url = "/no-cover.gif"
    end

    @book = Book.new(isbn: isbn,
                     title: good_reads["best_book"]["title"],
                     author: good_reads["best_book"]["author"]["name"],
                     summary: isbndb.gsub(/�/, "'"),
                     year_of_publication: good_reads["original_publication_year"],
                     gr_rating: good_reads["average_rating"],
                     cover_url: pic_url,
                     data: r)
  end
end
