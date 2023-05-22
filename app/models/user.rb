class User < ApplicationRecord
  has_many :viewing_party_users
  has_many :viewing_parties, through: :viewing_party_users

  validates :email, uniqueness: true, presence: true
  validates  :name, presence: true
  validates :password, presence: true, confirmation: true

  has_secure_password

  def other_users
    User.where.not(id: self.id)
  end

  def hosted_parties
    viewing_parties.where(viewing_party_users: { host: true })
  end

  def invited_parties
    viewing_parties.where(viewing_party_users: { host: false })
  end
end