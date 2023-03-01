class User < ApplicationRecord
  before_destroy :prevent_deletion
  before_update :prevent_updation

  validates :sender_wallet_id, presence: true
  validates :receiver_wallet_id, presence: true
  validates :amount_debited, presence: true
  validates :amount_credited, presence: true
  validates :transaction_fee, presence: true

  validate :validate_transfer

  #from wallet not equals to wallet

  def validate_transfer
    raise ("invalid transation, cannot transfer money to self") if self.sender_wallet_id == self.receiver_wallet_id
  end

  def prevent_deletion
    raise ("cannot destroy")
  end

  def prevent_updation
    raise ("cannot update")
  end
end