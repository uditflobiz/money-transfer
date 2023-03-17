class GetWallet < ApplicationService
  def initialize(user_id, currency)
    @user_id = user_id
    @currency = currency
  end

  def call
    Wallet.find_or_create_by(user_id: @user_id, currency: @currency)
  end
end