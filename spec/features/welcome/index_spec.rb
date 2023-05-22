require 'rails_helper'

RSpec.describe "Landing page", type: :feature do

  before(:each) do
    @user1 = User.create!(name: "Bob", email: "bob@bob.com", password: "password")
    @user2 = User.create!(name: "John", email: "john@john.com", password: "password")
    @user3 = User.create!(name: "Jack", email: "Jack@jack.com", password: "password")
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
end