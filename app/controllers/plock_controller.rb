class PlockController < Devise::RegistrationsController
  def new
    @campus = Campus.all
    super
  end

  def edit
    @campus = Campus.all
    super
  end
end
