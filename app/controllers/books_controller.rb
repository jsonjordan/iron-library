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

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: { status: :ok } }
    end
  end

end
