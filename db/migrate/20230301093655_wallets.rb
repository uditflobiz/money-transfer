class Wallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.references :user
      t.integer :currency
      t.decimal :amount, default: 0, precision: 10, scale: 2
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
