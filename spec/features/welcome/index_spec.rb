require 'rails_helper'

RSpec.describe "Landing page", type: :feature do

  before(:each) do
    @user1 = User.create!(name: "Bob", email: "bob@bob.com", password: "password")
    @user2 = User.create!(name: "John", email: "john@john.com", password: "password")
    @user3 = User.create!(name: "Jack", email: "Jack@jack.com", password: "password")
    visit new_session_path
    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password
    click_button "Log In"

    visit '/'
  end

  describe "When I visit the Landing page" do
    it "I see the title of the application, a button to register, and a list of current users" do
      expect(page).to have_link("Home")
      expect(page).to have_content("Viewing Party")
      expect(page).to have_button("Register")

      within("#current-users") do
        expect(page).to have_content("Current Users")
        expect(page).to have_link(@user1.name)
        expect(page).to have_link(@user2.name)
        expect(page).to have_link(@user3.name)
      end
    end

    it 'When I click on the register button I see the Home link on that page and it takes me back to the root' do
      click_button "Register"
      expect(current_path).to eq("/register")
      expect(page).to have_link("Home")
      click_link "Home"
      expect(current_path).to eq(root_path)
    end
    
    it 'When I click on a users name I see the Home link on the page and it takes me back to the root' do
      click_link "#{@user1.name}"
      expect(current_path).to eq(user_path(@user1))
      expect(page).to have_link("Home")
      click_link "Home"
      expect(current_path).to eq(root_path)
    end
  end

# As a logged in user 
# When I visit the landing page
# I no longer see a link to Log In or Register
# But I see a link to Log Out.
# When I click the link to Log Out
# I'm taken to the landing page
# And I can see that the Log Out link has changed back to a Log In link

  describe 'When I am logged in' do
    it "I no longer see a link to Log In or Register but I see a link to Log Out" do
      visit new_session_path

      fill_in :email, with: @user1.email
      fill_in :password, with: @user1.password

      click_button "Log In"

      visit '/'

      expect(page).to_not have_button("Log In")
      expect(page).to_not have_button("Register")
      expect(page).to have_button("Log Out")

      expect(page).to have_content("Welcome, Bob!")

      click_button "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_button("Log In")
      expect(page).to have_button("Register")
    end
  end
end