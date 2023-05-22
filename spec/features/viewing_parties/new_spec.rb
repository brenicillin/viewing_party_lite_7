require 'rails_helper'

RSpec.describe 'viewing_parties new page', type: :feature do

  before(:each) do
    @user1 = User.create!(name: "Bob", email: "bob@bob.com", password: "password")
    @user2 = User.create!(name: "Jeff", email: "jeff@bob.com", password: "password")
    stub_request(:get, "https://api.themoviedb.org/3/movie/5?api_key=#{ENV['MOVIE_API_KEY']}")
      .to_return(status: 200, body: File.read("./spec/fixtures/four_rooms_info.json"))
    visit new_user_movie_viewing_party_path(@user1, 5)
  end

  describe 'when I visit the viewing_parties new page' do
    it 'I see a form to create a viewing party' do
      expect(page).to have_content("Four Rooms Viewing Party")
      expect(page).to have_field("Duration")

      expect(page).to have_field("viewing_party[date]")

      expect(page).to have_field("viewing_party[time]")

      expect(page).to have_unchecked_field(@user2.name)

      expect(page).to have_button("Create Viewing Party")
    end

    it 'When I click the button to create a viewing party I am taken to the new page' do
      fill_in "Duration", with: 98
      
      fill_in "viewing_party[date]", with: Date.today

      fill_in "viewing_party[time]", with: Time.now + 1.hours
      
      check (@user2.name)

      click_button("Create Viewing Party")

      expect(current_path).to eq(user_path(@user1))

      visit(user_path(@user2))
      expect(page).to have_content("Four Rooms")
    end
  end 
end