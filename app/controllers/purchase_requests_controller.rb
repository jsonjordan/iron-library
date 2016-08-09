class PurchaseRequestsController < ApplicationController

  def show
    @pr = PurchaseRequest.find(params[:id])
  end

  def index
    @prs = PurchaseRequest.all
  end

  def new
    @pr = PurchaseRequest.new
  end

  def create
    pr = PurchaseRequest.new approved_params
    if pr.save
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
    pr = PurchaseRequest.find(params[:id])
    if pr.update approved_params
      flash[:notice] = "Purchase Request updated!"
      purchase_request_path(pr)
    else
      render :edit
    end
  end
end
