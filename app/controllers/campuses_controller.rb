class CampusesController < ApplicationController

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

  end

  def edit
    @campus = Campus.find(params[:id])
  end

  def update
    @campus = Campus.find(params[:id])
  end

end
