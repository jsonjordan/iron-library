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

  def results
    @campus = Campus.find params[:campu_id]
    @book = @campus.books.new(isbn: params[:book][:isbn])
  end

  def create
    @campus = Campus.find params[:campu_id]
    @book = @campus.books.new #approved_params
    if @book.save
      flash[:notice] = "Book added!"
      redirect_to "/campus/#{params[:campu_id]}/books"
    else
      render :new
    end
  end

  def edit

  end

  def update

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

  def approved_params
    #params.require
  end

end
