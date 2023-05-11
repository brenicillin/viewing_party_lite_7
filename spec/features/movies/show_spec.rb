require 'rails_helper'

RSpec.describe "Movie Show Page" do
  before(:each) do
    @user = User.create!(name: "Bob", email: "bob@bob.com")
    visit user_movie_path(@user, 5)
  end
  describe "When I visit a movie's show page" do
    it "I see a button to create a viewing party" do
      expect(page).to have_button("Create a Viewing Party")
    end

    it "I see a button to return to the Discover Page" do
      expect(page).to have_button("Back")

      click_button("Back")

      expect(current_path).to eq(user_discover_path(@user))
    end

    it "I see the movie's title, vote average, runtime, genre(s), and summary" do
      expect(page).to have_content("Four Rooms")
      expect(page).to have_content("Rating: 5.759")
      expect(page).to have_content("Runtime: 98")
      expect(page).to have_content("Crime")
      expect(page).to have_content("Comedy")
      expect(page).to have_content("Overview: It's Ted the Bellhop's first night on the job...and the hotel's very unusual guests are about to place him in some outrageous predicaments. It seems that this evening's room service is serving up one unbelievable happening after another.")
    end
  end
end