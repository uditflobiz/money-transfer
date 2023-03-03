class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password
  has_one_time_password

  has_many :wallet

  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Incorrect email" }, uniqueness: true
  validates :password_digest, presence: true

  before_create :set_values

  def set_values
    self.kyc_completed = false
  end
end