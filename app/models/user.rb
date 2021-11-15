class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, on: :create

  def self.generate_api_key
    SecureRandom.urlsafe_base64
  end
end
