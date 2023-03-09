class Wallet < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :currency

  validates :user_id, presence: true
  validates :currency, presence: true
end