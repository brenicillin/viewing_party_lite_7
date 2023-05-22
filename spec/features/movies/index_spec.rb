require 'rails_helper'

RSpec.describe "movie results page", type: :feature do
  before(:each) do
    @user1 = User.create!(name: "Bob", email: "bob@bob.com", password: "password")
    @user2 = User.create!(name: "John", email: "john@bob.com", password: "password")
    visit user_discover_path(@user1)
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}")
      .to_return(status: 200, body: File.read("./spec/fixtures/top_rated_movies.json"))
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=The%20fellowship%20of%20the%20ring")
      .to_return(status: 200, body: File.read("./spec/fixtures/search_movie.json"))
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=the")
      .to_return(status: 200, body: File.read("./spec/fixtures/search_movie_the.json"))
  end

  
  describe "when I visit the movie results page" do
    it "after I click the top rated movies I see the top rated movies" do
      click_button("Discover Top Movies")
      expect(current_path).to eq("/users/#{@user1.id}/movies")

      expect(page).to have_link("The Godfather")
      expect(page).to have_content("Rating: 8.7")

      expect(page).to have_button("Back")
      click_button("Back")
      expect(current_path).to eq(user_discover_path(@user1))
    end

    it "after I search a movie I see movies that are that movie" do
      fill_in "title", with: ("The fellowship of the ring")
      click_button("Search")
      expect(current_path).to eq("/users/#{@user1.id}/movies")

      expect(page).to have_link("The Lord of the Rings: The Fellowship of the Ring")
      expect(page).to have_content("Rating: 8.4")

      expect(page).to have_button("Back")
      click_button("Back")
      expect(current_path).to eq(user_discover_path(@user1))
    end

    it "if I search with a key word movies with that word in it appear" do
      fill_in "title", with: ("the")
      click_button("Search")
      expect(current_path).to eq("/users/#{@user1.id}/movies")

      expect(page).to have_link("The Pope's Exorcist")
      expect(page).to have_content("Rating: 7.316")

      expect(page).to have_button("Back")
      click_button("Back")
      expect(current_path).to eq(user_discover_path(@user1))
    end
  end
end