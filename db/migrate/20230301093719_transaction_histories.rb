class TransactionHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_histories do |t|
      t.references :sender_wallet, foreign_key: {to_table: :wallets}, null: true
      t.references :receiver_wallet, foreign_key: {to_table: :wallets}
      t.float :amount_debited
      t.float :amount_credited
      t.float :transaction_fee
      t.boolean :wallet_top_up

      t.timestamps
    end
  end
end
