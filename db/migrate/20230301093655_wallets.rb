class Wallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.references :user
      t.references :currency
      t.float :amount, default: 0
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
