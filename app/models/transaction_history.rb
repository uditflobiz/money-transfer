class TransactionHistory < ApplicationRecord
  before_destroy :prevent_deletion
  before_update :prevent_updation

  belongs_to :sender_wallet, class_name: 'Wallet', foreign_key: 'sender_wallet_id', optional: true
  belongs_to :receiver_wallet, class_name: 'Wallet', foreign_key: 'receiver_wallet_id'

  validates :wallet_top_up, inclusion: [true, false]
  validates :sender_wallet_id, presence: true, if: Proc.new { |t| t.wallet_top_up == false}
  validates :receiver_wallet_id, presence: true
  validates :amount_debited, presence: true, if: Proc.new { |t| t.wallet_top_up == false }
  validates :amount_credited, presence: true
  validates :transaction_fee, presence: true, if: Proc.new { |t| t.wallet_top_up == false && (t.sender_wallet.user_id != t.receiver_wallet.user_id)}

  def prevent_deletion
    raise ("transaction history cannot be destroyed")
  end

  def prevent_updation
    raise ("transaction history cannot be updated")
  end
end