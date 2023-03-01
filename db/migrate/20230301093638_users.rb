class Users < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :aadhaar_number, unique: true
      t.string :aadhaar_url
      t.boolean :kyc_completed
      t.string :otp_secret_key
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
