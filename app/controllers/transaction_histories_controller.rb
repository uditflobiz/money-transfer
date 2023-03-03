class TransactionHistoriesController < ApplicationController
  before_action :authorized, only: [:get_transaction_history]

  def get_transaction_history
    wallet = @user.wallet.pluck(:id)
    render json: TransactionHistory.where(sender_wallet_id: wallet).or(TransactionHistory.where(receiver_wallet_id: wallet)).order(:created_at).page(params[:page_no]).per(10)
  end
end