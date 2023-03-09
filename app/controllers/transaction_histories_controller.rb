class TransactionHistoriesController < ApplicationController
  def get_transaction_history
    wallet = User.find_by(id: get_user_id).wallet.pluck(:id)
    render json: TransactionHistory.where(sender_wallet_id: wallet).or(TransactionHistory.where(receiver_wallet_id: wallet)).order(:created_at).page(params[:page_no]).per(5)
  end
end