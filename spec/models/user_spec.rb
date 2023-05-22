require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user_1 = User.create!(name: "Bob", email: "bobert@bob.com", password: 'password123')
    @user_2 = User.create!(name: "Jeff", email: "jefferey@bob.com", password: 'password123')
    @user_3 = User.create!(name: "Sally", email: "sally@bob.com", password: 'password123')

    @viewing_party_1 = ViewingParty.create!(duration: 1, date: Date.current, time: Time.current, movie_id: 5)

    ViewingPartyUser.create!(user_id: @user_1.id, viewing_party_id: @viewing_party_1.id, host: true)
    ViewingPartyUser.create!(user_id: @user_2.id, viewing_party_id: @viewing_party_1.id, host: false)
    ViewingPartyUser.create!(user_id: @user_3.id, viewing_party_id: @viewing_party_1.id, host: false)
  end
  describe 'relationships' do
    it { should have_many(:viewing_party_users) }
    it { should have_many(:viewing_parties).through(:viewing_party_users) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password)}
    it { should have_secure_password }
    it 'should have secure password' do
      expect(@user_1).to_not have_attribute(:password)
      expect(@user_1.password_digest).to_not eq('password123')
    end
  end

  describe 'authentication' do

  end

  describe 'instance methods' do
    it '#other_users' do
      expect(@user_1.other_users).to eq([@user_2, @user_3])
    end

    it '#hosted_parties' do
      expect(@user_1.hosted_parties).to eq([@viewing_party_1])
      expect(@user_2.hosted_parties).to eq([])
      expect(@user_3.hosted_parties).to eq([])
    end

    it '#invited_parties' do
      expect(@user_1.invited_parties).to eq([])
      expect(@user_2.invited_parties).to eq([@viewing_party_1])
      expect(@user_3.invited_parties).to eq([@viewing_party_1])
    end
  end
end