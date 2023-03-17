class TransferMoney < ApplicationService
  def initialize(sender_user_id,  receiver_user_id, otp, sender_currency, receiver_currency, amount)
    @sender_user_id = sender_user_id
    @receiver_user_id = receiver_user_id
    @otp = otp
    @sender_currency = sender_currency
    @receiver_currency = receiver_currency
    @amount = amount
  end

  def call
    ActiveRecord::Base.transaction do
      otp_status = CheckOtp.call(@sender_user_id, @otp)
      raise AuthorizationError.new("Otp is incorrect") if !otp_status

      sender = User.find_by(id: @sender_user_id)
      raise CustomError.new("sender's kyc is not completed") if !sender.kyc_completed

      receiver = User.find_by(id: @receiver_user_id)
      raise CustomError.new("receiver's kyc is not completed") if !receiver.kyc_completed

      sender_wallet = GetWallet.call(@sender_user_id, @sender_currency)
      receiver_wallet = GetWallet.call(@receiver_user_id, @receiver_currency)

      transaction_fee = 2

      raise CustomError.new("Not enough balance in wallet") if(sender_wallet[:amount] - (@amount.to_d  + transaction_fee) < 0)
      sender_wallet[:amount] = sender_wallet[:amount] - (@amount.to_d  + transaction_fee)
      sender_wallet.save!

      receiving_amount = @amount.to_d * $redis.get("#{@sender_currency}##{@receiver_currency}").to_d
      receiver_wallet[:amount] = receiver_wallet[:amount] + receiving_amount
      receiver_wallet.save!
      
      TransactionHistory.create(receiver_wallet_id: receiver_wallet[:id], sender_wallet_id: sender_wallet[:id], amount_credited: receiving_amount, amount_debited: @amount.to_d, transaction_fee: transaction_fee, wallet_top_up: false)
    end
  end
end