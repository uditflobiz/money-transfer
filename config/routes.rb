Rails.application.routes.draw do
  post "/create", to: "users#create"
  post "/login", to: "users#login"
  post "/login_2FA", to: "users#login_2FA"
  post "/update_kyc", to: "users#upload_kyc_docs"
  post "/verify_user_kyc", to: "users#verify_kyc"

  post "/top_up", to: "wallets#top_up"
  post "/transfer_money", to: "wallets#transfer_money"

  get "/user_transaction_history", to: "transaction_histories#get_transaction_history"

  #test
  get "/temp", to: "users#temp"
end
