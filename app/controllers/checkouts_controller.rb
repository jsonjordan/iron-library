class CheckoutsController < ApplicationController

  def index
    @book = Book.find(params[:book_id])
    @checkouts = @book.checkouts.order(:created_at).includes(:user).reverse
  end

  def user_index
    @user = User.find(params[:user_id])
    @checkouts = @user.checkouts.order(:status).includes(:book)
  end

  def campus_index
    @checkouts = Campus.find(params[:campu_id]).checkouts.order(:status).includes(:book, :user)
  end

  def create
    @book = Book.find params[:book_id]
    @checkout = @book.checkouts.new(user: current_user,
                                    due_date: Time.now + 1.weeks)

    if @checkout.save
      @book.status = "checked out"
      @book.save
      if res = current_user.has_reservation?(@book)
        res.destroy_all
      end
      flash[:notice] = "Book checked out!"
      redirect_to @book
    else
      flash[:warning] = "Book could not be checked out"
      redirect_to @book
    end

  end

  def check_in
    @user = User.find(params[:user_id])
    @checkouts = @user.checkouts.where.not(status: "checked in").includes(:book)
  end

  def update
    checkout = Checkout.find params[:id]
    checkout.status = "checked in"
    if checkout.save
      book = checkout.book
      if book.reservations.count > 0
        book.status = "on reserve"
      else
        book.status = "in"
      end
      book.save
      flash[:notice] = "Book checked in!"
      redirect_to user_checkouts_path(current_user)
    else
      flash[:warning] = "Book could not be checked in"
      redirect_to user_checkouts_path(current_user)
    end
  end
end
