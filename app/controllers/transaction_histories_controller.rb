class TransactionHistoriesController < ApplicationController
  before_action :get_user, only: [:index]

  def index
    wallet = User.find_by(id: current_user[:id]).wallets.pluck(:id)
    binding.pry
    render json: TransactionHistory.where(sender_wallet_id: wallet).or(TransactionHistory.where(receiver_wallet_id: wallet)).order(:created_at).page(params[:page_no]).per(5)
  end
end