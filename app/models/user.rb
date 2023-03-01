class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password
  has_one_time_password

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "incorrect email" }
  validates :password_digest, presence: true

  before_update :prevent_updation
  after_update :create_wallet


  def prevent_updation
    if self.kyc_completed
      raise('KYC completed, cannot modify user')
    end
  end

  def create_wallet
    if self.kyc_completed
      #create wallet api
    end
  end
end