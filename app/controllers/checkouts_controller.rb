class CheckoutsController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.includes(:user)
  end

  def index
    @books = Book.where(confirmed: true)
  end

  def user_index
    @checkouts = User.find(params[:user_id]).checkouts.order(:status).includes(:book)
  end

  def campus_index
    @books = Book.where(campus_id: params[:campu_id], confirmed: true)
  end

  def new
    @campus = Campus.find params[:campu_id]
    @book = @campus.books.new
  end

  def create
    @book = Book.find params[:book_id]
    @checkout = @book.checkouts.new(user: current_user,
                                   due_date: Time.now + 1.weeks)

    if @checkout.save
      @book.status = "checked out"
      @book.save
      flash[:notice] = "Book checked out!"
      redirect_to @book
    else
      flash[:warning] = "Book could not be checked out"
      redirect_to @book
    end

  end

  def check_in
    @checkouts = User.find(params[:user_id]).checkouts.where.not(status: "checked in").includes(:book)
  end

  def update
    checkout = Checkout.find params[:id]
    checkout.status = "checked in"
    if checkout.save
      book = checkout.book
      book.status = "in"
      book.save
      flash[:notice] = "Book checked in!"
      redirect_to user_checkouts_path(current_user)
    else
      flash[:warning] = "Book could not be checked in"
      redirect_to user_checkouts_path(current_user)
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

end
