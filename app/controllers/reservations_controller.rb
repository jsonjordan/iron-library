class ReservationsController < ApplicationController

  def book_index
    @book = Book.find(params[:book_id])
    @checkouts = @book.checkouts.order(:created_at).includes(:user).reverse
  end

  def user_index
    @checkouts = User.find(params[:user_id]).checkouts.order(:status).includes(:book)
  end

  def create
    @book = Book.find params[:book_id]
    @reservation = @book.reservations.new(user: current_user)

    if @reservation.save
      flash[:notice] = "Book reserved!"
      redirect_to @book
    else
      flash[:warning] = "Book could not be reserved"
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
      book.status = "in"
      book.save
      flash[:notice] = "Book checked in!"
      redirect_to user_checkouts_path(current_user)
    else
      flash[:warning] = "Book could not be checked in"
      redirect_to user_checkouts_path(current_user)
    end
  end
end
