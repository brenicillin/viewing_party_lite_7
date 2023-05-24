class DiscoverController < ApplicationController
  def index
    if current_user
    @user = current_user
    else
      flash[:alert] = "Please log in to view this page."
      redirect_to root_path
    end
  end
end