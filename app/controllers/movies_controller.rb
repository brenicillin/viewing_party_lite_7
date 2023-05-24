class MoviesController < ApplicationController
  def index
    if current_user
      @user = User.find(session[:user_id])
      @movies = nil
      if params[:commit] == "Search"
        @movies = MovieFacade.movie_search(params[:title])
      else
        @movies = MovieFacade.top_rated_movies
      end
    else
      flash[:alert] = "Please log in to view this page."
      redirect_to root_path
    end
  end

  def show 
    if current_user
      @user = User.find(session[:user_id])
      @movie = MovieFacade.movie_details(params[:id])
      @cast = MovieFacade.cast(params[:id])
      @reviews = MovieFacade.reviews(params[:id])
    else
      @movie = MovieFacade.movie_details(params[:id])
      @cast = MovieFacade.cast(params[:id])
      @reviews = MovieFacade.reviews(params[:id])
    end
  end
end