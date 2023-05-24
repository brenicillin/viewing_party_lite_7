class ViewingPartiesController < ApplicationController

  def new
    if current_user
      @user = current_user
      @movie = MovieFacade.movie_details(params[:movie_id])
      @all_other_users = @user.other_users
      @party = ViewingParty.new
    else
      flash[:alert] = "Please log in to view this page."
      redirect_to root_path
    end
  end

  def create
    if current_user
      @user = current_user
      @viewing_party = ViewingParty.create(viewing_party_params)
      @viewing_party.save
      @invited = User.where(id: params[:viewing_party][:users])
      @viewing_party.users = @invited
      ViewingPartyUser.create(user_id: @user.id, viewing_party_id: @viewing_party.id, host: true)
      redirect_to user_path(@user)
    else
      flash[:alert] = "Please log in to view this page."
      redirect_to root_path
    end
  end

  private
  
  def viewing_party_params
    params.require(:viewing_party).permit(:duration, :date, :time, :movie_id)
  end
end