class WalletsController < ApplicationController
  before_action :get_user, only: [:top_up, :transfer_money, :request_otp]

  def subtract_money(wallet_id, amount)
    wallet = Wallet.find(wallet_id)
    raise("Not enough balance in wallet") if(wallet[:amount] - amount.to_d < 0)
    wallet[:amount] = wallet[:amount] - amount.to_d
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
    TopUp.call(current_user[:id], params[:otp], params[:currency], params[:amount])
    render json: {status: 200, message: 'Amounted added successfully'}
  end

  def transfer_money
    TransferMoney.call(current_user[:id], params[:receiver_user_id], params[:otp], params[:sender_currency], params[:receiver_currency], params[:amount])
    render json: {status: 200, message: 'Amounted transffered successfully'}
  end

  def request_otp
    user = User.find_by(id: current_user[:id])
    OtpMessageJob.perform_async("Your transaction OTP is #{user.otp_code}")
    render json: {status: 200}
  end
end