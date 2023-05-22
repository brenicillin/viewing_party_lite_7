require 'rails_helper'

RSpec.describe 'User Login Page' do
  describe 'As a visitor' do
    it 'I see a form to log in as a user' do
      visit '/'

      click_link "Log In"

      expect(current_path).to eq("/login")

      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
      expect(page).to have_button("Log In")
    end

    it 'I can log in as a user' do
      user = User.create!(name: "Bob", email: "bobby@bob.com", password: "password")

      visit '/login'

      fill_in "Email", with: user.email
      fill_in "Password", with: "password"

      click_button "Log In"

      expect(current_path).to eq(user_path(user))

      expect(page).to have_content("Welcome, #{user.name}!")
    end

    it 'I see a flash message if login is unsuccessful' do
      user = User.create!(name: "Bob", email: "bobby@bob.com", password: "password")

      visit '/login'

      fill_in "Email", with: user.email
      fill_in "Password", with: "wrongpassword"

      click_button "Log In"

      expect(current_path).to eq("/login")
      expect(page).to have_content("Incorrect email/password combination.")
    end
  end
end