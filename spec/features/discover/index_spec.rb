require 'rails_helper'

RSpec.describe 'Discover Movies Page' do
  before(:each) do
    @user1 = User.create!(name: "Bob", email: "bob@bob.com", password: "password")
    @user2 = User.create!(name: "John", email: "john@bob.com", password: "password")
    visit user_discover_path(@user1)
  end
  
  describe "As a user" do
    it 'I should see a button to discover top rated movies' do

      within "#discover-movies" do
        expect(page).to have_button("Discover Top Movies")
      end
    end

    it 'I should see a text field to search by movie title' do

      within "#title-search" do
        expect(page).to have_field("Movie Title")
        expect(page).to have_button("Search")
      end
    end
  end
end