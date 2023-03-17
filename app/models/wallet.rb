class Wallet < ApplicationRecord
  acts_as_paranoid

  #TODO
  #add associations
  enum currency: {
    inr: 1,
    usd: 2,
    eur: 3,
    gbm: 4,
    yen: 5
  }

  belongs_to :user
  has_many :transaction_histories

  validates :user_id, presence: true
  validates :currency, presence: true
end