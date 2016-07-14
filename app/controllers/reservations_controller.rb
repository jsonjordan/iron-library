class ReservationsController < ApplicationController

  def book_index
    @book = Book.find(params[:book_id])
    @reservations = @book.reservations.order(:created_at).includes(:user)
  end

  def user_index
    @user = User.find(params[:user_id])
    @reservations = @user.reservations.includes(:book)
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

  def destroy

  end
end
