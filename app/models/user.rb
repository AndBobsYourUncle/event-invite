class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :invitations, inverse_of: :user, validate: false
  has_one :invitation, -> { order(id: :desc) }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
