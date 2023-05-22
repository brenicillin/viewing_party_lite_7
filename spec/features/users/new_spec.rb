require 'rails_helper'

RSpec.describe "User Registration Page", type: :feature do
  describe "As a visitor" do
    it 'I see a form to register as a user' do
      visit '/register'

      within "#registration-form" do
        expect(page).to have_content("Name")
        expect(page).to have_content("Email")
        expect(page).to have_content("Password")
        expect(page).to have_content("Confirm Password")
        expect(page).to have_button("Register User")
      end
    end

    it 'I see a link to return to the landing page' do
      visit '/register'
      expect(page).to have_link("Home")

      click_link "Home"
      
      expect(current_path).to eq("/")
    end

    it 'I can register a new user sad path' do 
      visit '/register'

      fill_in "Name", with: "Bob"
      fill_in "Email", with: "bob@bob.com"
      click_button "Register User"

      expect(current_path).to eq("/register")
    end

    it 'create a user happy path' do
      visit '/register'

      fill_in "Name", with: "Bob"
      fill_in "Email", with: "bobbert@bob.com"
      fill_in "Password", with: "password123"
      fill_in "Confirm Password", with: "password123"
      click_button "Register User"
      
      save_and_open_page
      expect(current_path).to eq("/users/#{User.last.id}")
      
    end

    it 'I see a flash message if creation is unsuccessful' do
      visit '/register'
      click_button "Register User"

      expect(page).to have_content("Please fill in all fields. Email must be unique.")
    end
  end
end