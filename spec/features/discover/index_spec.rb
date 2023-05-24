require 'rails_helper'

RSpec.describe 'Discover Movies Page' do
  before(:each) do
    @user1 = User.create!(name: "Bob", email: "bob@bob.com", password: "password")
    @user2 = User.create!(name: "John", email: "john@bob.com", password: "password")
    
  end

  let :current_user do
    current_user = @user1
  end
  
  describe "As a user" do
    it 'I should see a button to discover top rated movies' do
      visit discover_path
      save_and_open_page
    
      within "#discover-movies" do
        expect(page).to have_button("Discover Top Movies")
      end
    end

    it 'I should see a text field to search by movie title' do
      visit discover_path
      within "#title-search" do
        expect(page).to have_field("Movie Title")
        expect(page).to have_button("Search")
      end
    end
  end
end