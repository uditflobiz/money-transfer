class CheckOtp < ApplicationService
  def initialize(user_id, otp)
    @user_id = user_id
    @otp = otp
  end

  def call
    User.find_by(id: @user_id).authenticate_otp(@otp)
  end
end