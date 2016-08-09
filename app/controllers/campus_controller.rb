class CampusController < ApplicationController

  def show
    @campus = Campus.find(params[:id])
  end

  def index
    @campuses = Campus.all
  end

  def new
    @campus = Campus.new
  end

  def create
    campus = Campus.new approved_params
    if campus.save
      flash[:notice] = "Campus added!"
      redirect_to campus_path
    else
      render :new
    end
  end

  def edit
    @campus = Campus.find(params[:id])
  end

  def update
    campus = Campus.find(params[:id])
    if campus.update approved_params
      flash[:notice] = "Campus updated!"
      redirect_to campu_path(campus)
    else
      render :edit
    end
  end

  private

  def approved_params
    params.require(:campus).permit(:street_address, :city, :state, :zip_code, :librarian)
  end

end
