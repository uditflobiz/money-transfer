class TopUp < ApplicationService
  def initialize(user_id, otp, currency, amount)
    @user_id = user_id
    @otp = otp
    @currency = currency
    @amount = amount
  end

  def call
    ActiveRecord::Base.transaction do
      otp_status = CheckOtp.call(@user_id, @otp)
      raise OtpError if !otp_status
      
      user = User.find_by(id: @user_id)
      raise KycError if !user.kyc_completed

      wallet = GetWallet.call(@user_id, @currency)
      wallet[:amount] = wallet[:amount] + @amount.to_f
      wallet.save!

      TransactionHistory.create(receiver_wallet_id: wallet[:id], amount_credited: @amount.to_f, transaction_fee: 0, wallet_top_up: true)
    end
  end
end