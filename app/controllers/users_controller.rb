class UsersController < ApplicationController
  
  def show 
    @user = User.find(params[:id])
    @invited_parties = @user.invited_parties
    @hosted_parties = @user.hosted_parties
  end
  
  def new
  end

  def create
    @user = User.create(user_params)
    if params[:password] == params[:password_confirmation]
      if @user.save 
        redirect_to user_path(@user)
      else 
        redirect_to "/register"
        flash[:alert] = "Please fill in all fields. Email must be unique."
      end
    else
      redirect_to "/register"
      flash[:alert] = "Passwords do not match."
    end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      redirect_to user_path(user)
      flash[:notice] = "Welcome, #{user.name}! You are now logged in."
    else
      redirect_to "/login"
      flash[:alert] = "Incorrect email/password combination."
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end