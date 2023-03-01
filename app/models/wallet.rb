class Wallet < ApplicationRecord
  acts_as_paranoid

  validates: user_id, presence: true
  validates: currency, presence: true
end