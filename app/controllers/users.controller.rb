class UsersController < ApplicationController


  def show

  end

  def index
    @users = User.all
  end

  def edit

  end

  def update

  end

  def destroy

  end



  private

  def set_user
    @user = current_user
  end

  def approved_params
    params.require(:user).permit(:name, :email, :permission)
  end
