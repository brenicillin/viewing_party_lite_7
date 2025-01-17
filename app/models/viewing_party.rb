class ViewingParty < ApplicationRecord
  has_many :viewing_party_users
  has_many :users, through: :viewing_party_users

  validates :date , presence: true
  validates :time , presence: true
  validates :duration , numericality: { only_integer: true }

  def movie_title 
    movie = MovieFacade.movie_details(self.movie_id)
    movie.title
  end

  def get_image
    image = MovieService.find_by_id(self.movie_id)[:poster_path]
  end
end