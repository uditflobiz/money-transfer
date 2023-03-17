class Users < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone_number
      t.string :aadhaar_number
      t.string :aadhaar_url
      t.boolean :kyc_completed, default: false
      t.string :otp_secret_key
      t.timestamp :deleted_at
      
      t.index :phone_number, unique: true
      t.index :aadhaar_number, unique: true

      t.timestamps
    end
  end
end
