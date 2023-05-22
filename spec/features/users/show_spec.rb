require 'rails_helper'

RSpec.describe "User Dashboard", type: :feature do

  before(:each) do
    @user1 = User.create!(name: "Bob", email: "bob@bob.com", password: "password")
    @user2 = User.create!(name: "John", email: "john@john.com", password: "password")

    @viewing1 = ViewingParty.create!(duration: 1, date: Date.current, time: Time.current, movie_id: 5)
    @viewing1.users = [@user1, @user2]
    stub_request(:get, "https://api.themoviedb.org/3/movie/5?api_key=#{ENV['MOVIE_API_KEY']}")
      .to_return(status: 200, body: File.read("./spec/fixtures/four_rooms_info.json"))

    stub_request(:get, "https://api.themoviedb.org/3/movie/5/credits?api_key=#{ENV['MOVIE_API_KEY']}")
      .to_return(status: 200, body: File.read("./spec/fixtures/four_rooms_credits.json"))
    
    stub_request(:get, "https://api.themoviedb.org/3/movie/5/reviews?api_key=#{ENV['MOVIE_API_KEY']}")
      .to_return(status: 200, body: File.read("./spec/fixtures/four_rooms_reviews.json"))
    
    visit(user_path(@user1))
  end

  describe "When I visit a Users dashboard page" do
    it "I see a header with the users name, a button to discover movies, and a list with all viewing parties" do
      expect(page).to have_content("#{@user1.name}'s Dashboard")
      expect(page).to have_button("Discover Movies")
      within("#invited-parties") do
        expect(page).to have_link("Four Rooms")
        click_link("Four Rooms")
      end

      expect(current_path).to eq(user_movie_path(@user1, 5))
    end

    it 'I see a button to discover movies' do

      within "#discover-movies" do
        expect(page).to have_button("Discover Movies")
        click_button "Discover Movies"
      end

      expect(current_path).to eq(user_discover_path(@user1))
    end
  end
end
