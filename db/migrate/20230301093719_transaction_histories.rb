class TransactionHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_histories do |t|
      t.references :sender_wallet, foreign_key: {to_table: :wallets}, null: true
      t.references :receiver_wallet, foreign_key: {to_table: :wallets}
      t.decimal :amount_debited,  precision: 10, scale: 2
      t.decimal :amount_credited, precision: 10, scale: 2
      t.decimal :transaction_fee, precision: 10, scale: 2
      t.boolean :wallet_top_up

      t.timestamps
    end
  end
end
