class WalletsController < ApplicationController
  before_action :authorized, only: [:top_up, :transfer_money]

  def get_wallet(user_id, currency)
    wallet = Wallet.find_or_create_by(user_id: user_id, currency: currency)
    wallet
    return wallet
  end

  def subtract_money(wallet_id, amount)
    wallet = Wallet.find(wallet_id)
    raise("Not enough balance in wallet") if(wallet[:amount] - amount.to_f < 0)
    wallet[:amount] = wallet[:amount] - amount.to_f
    wallet.save!
  end

  def add_money(wallet_id, amount)
    wallet = Wallet.find(wallet_id)
    wallet[:amount] = wallet[:amount] + amount
    wallet.save!
  end

  def otp_check(user, otp)
    return user.authenticate_otp(otp)
  end

  def top_up
    ActiveRecord::Base.transaction do
      if otp_check(@user, params[:otp]) & @user.kyc_completed
        wallet = get_wallet(@user[:id], params[:currency])
        add_money(wallet[:id], params[:amount].to_f)
        TransactionHistory.create(receiver_wallet_id: wallet[:id], amount_credited: params[:amount].to_f, transaction_fee: 0, wallet_top_up: true)
      else
        render json: {error: 'Incorrect otp'}
      end
    end
  end

  def transfer_money
    ActiveRecord::Base.transaction do
      params = transfer_money_params
      receiver = User.find(params[:receiver_user_id])
      if otp_check(@user, params[:otp]) & @user.kyc_completed & receiver.kyc_completed
        sender_wallet = get_wallet(@user[:id], params[:sender_currency])
        receiver_wallet = get_wallet(params[:receiver_user_id], params[:receiver_currency])
        transaction_fee = 2
        subtract_money(sender_wallet[:id], params[:amount].to_f + transaction_fee)
        receiving_amount = params[:amount].to_f * $redis.get("#{params[:sender_currency]}##{params[:receiver_currency]}").to_f
        add_money(receiver_wallet[:id], receiving_amount)
        TransactionHistory.create(receiver_wallet_id: receiver_wallet[:id], sender_wallet_id: sender_wallet[:id], amount_credited: receiving_amount, amount_debited: params[:amount].to_f,transaction_fee: transaction_fee, wallet_top_up: false)
      else
        render json: {error: 'Incorrect otp'}
      end
    end
  end

  private

  def transfer_money_params
    params.permit(:sender_currency, :amount, :otp, :receiver_user_id, :receiver_currency)
  end
end