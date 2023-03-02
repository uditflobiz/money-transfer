class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password
  has_one_time_password

  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Incorrect email" }, uniqueness: true
  validates :password_digest, presence: true

  # before_update :prevent_updation

  # def prevent_updation
  #   puts(self.kyc_completed_change)
  #   if !self.kyc_completed_change
  #     raise('KYC completed, cannot modify user')
  #   end
  # end
end