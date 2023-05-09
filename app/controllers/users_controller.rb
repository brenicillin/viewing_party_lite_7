class UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    pry
    if @user.save
      redirect_to user_path(@user)
    else 
      redirect_to "/register"
      flash[:alert] = "Please fill in all fields. Email must be unique."
    end
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end