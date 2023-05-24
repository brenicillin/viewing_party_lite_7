class UsersController < ApplicationController
  
  def show 
    if current_user 
      @user = current_user
      @invited_parties = @user.invited_parties
      @hosted_parties = @user.hosted_parties
    else
      flash[:alert] = "Please log in to view this page."
      redirect_to root_path
    end
  end
  
  def new
  end

  def create
    @user = User.create(user_params)
    if params[:password] == params[:password_confirmation]
      if @user.save 
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else 
        redirect_to "/register"
        flash[:alert] = "Please fill in all fields. Email must be unique."
      end
    else
      render :new
      flash[:alert] = "Passwords do not match."
    end
  end

  def login_form
  end

  def login_user
    if user = User.find_by(email: params[:email])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user)
        flash[:notice] = "Welcome, #{user.name}! You are now logged in."
      else
        redirect_to "/login"
        flash[:alert] = "Incorrect email/password combination."
      end
    else
      redirect_to "/login"
      flash[:alert] = "A user with this email does not exist."
    end
  end

  def logout_user
    if current_user
      session.delete(:user_id)
      redirect_to root_path
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end