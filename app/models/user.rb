class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password
  has_one_time_password

  has_many :wallets

  validates :name, presence: true, format: { with: /\A[a-z]+\z/i, }
  validates :phone_number, presence: true, uniqueness: true, length: { is: 10 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Incorrect email" }, uniqueness: true
  validates :password_digest, presence: true
  
end