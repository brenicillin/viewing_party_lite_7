class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
      flash[:notice] = "Welcome, #{user.name}! You are now logged in."
    else
      redirect_to "/login"
      flash[:alert] = "Incorrect credentials."
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end