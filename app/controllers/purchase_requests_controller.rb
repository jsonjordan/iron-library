class PurchaseRequestsController < ApplicationController

  def index
    @campus = Campus.find params[:campu_id]
    @prs = PurchaseRequest.where(campus_id: params[:campu_id], status: "pending").includes(:user)
    @prs_past = PurchaseRequest.where(campus_id: params[:campu_id]).where.not(status: "pending").includes(:user)
  end

  def user_index
    @prs = current_user.purchase_requests.all
  end

  def new
    @campus = Campus.find params[:campu_id]
    @pr = @campus.purchase_requests.new
  end

  def create
    @pr = current_user.purchase_requests.new approved_params
    gb = GetBook.new @pr.isbn
    book = gb.title_author
    @pr.title = book.first
    @pr.author = book.last
    @pr.status = "pending"
    if @pr.save
      flash[:notice] = "Purchase Request Made!"
      redirect_to campus_path
    else
      render :new
    end
  end

  def edit
    @pr = PurchaseRequest.find(params[:id])
  end

  def update
    @pr = PurchaseRequest.find(params[:id])
    if @pr.update approved_params
      if approved_params[:status] == 'purchased'
        gb = GetBook.new(@pr.isbn)
        book = gb.find
        redirect_to book_confirm_path(@pr.campus_id, isbn: book.isbn)
      else
        flash[:notice] = "Purchase Request updated!"
        redirect_to campu_purchase_requests_path(@pr.campus_id)
      end
    else
      render :edit
    end
  end

  private

  def approved_params
    params.require(:purchase_request).permit(:isbn, :klass, :campus_id, :status)
  end
end
