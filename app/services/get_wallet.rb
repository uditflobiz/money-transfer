class GetWallet < ApplicationService
  def initialize(user_id, currency)
    @user_id = user_id
    @currency = currency
  end

  def call
    currency_id = Currency.select(:id).find_by(currency: @currency)[:id]
    Wallet.find_or_create_by(user_id: @user_id, currency_id: currency_id)
  end
end