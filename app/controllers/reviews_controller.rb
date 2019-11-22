class ReviewsController < ApplicationController

  def new
    @book = Book.find params[:book_id]
    @review = @book.reviews.new(user_id: current_user.id)
  end

  def create
    @book = Book.find params[:book_id]
    @review = @book.reviews.new approved_params
    if @review.save
      flash[:notice] = "Review added!"
      redirect_to @book
    else
      render :new
    end
  end

  def edit
    @review = Review.find params[:id]
  end

  def update
    @review = Review.find params[:id]
    if @review.update approved_params
      flash[:notice] = "Review edited!"
      redirect_to @review.book
    else
      render :edit
    end
  end

  def destroy
    review = Review.find params[:id]
    review.destroy
    flash[:notice] = "Review deleted!"
    redirect_to :back
  end

  private

  def set_campus
    @campus = Campus.find params[:campu_id]
  end

  def approved_params
    params.require(:review).permit(:content, :user_id, :response)
  end

end
