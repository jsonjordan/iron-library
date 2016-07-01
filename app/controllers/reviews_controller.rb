class ReviewsController < ApplicationController

  def show

  end

  def index

  end


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
    params.require(:review).permit(:content, :user_id, :response)
  end


end
