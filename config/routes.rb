Rails.application.routes.draw do
  post "/create", to: "users#create"
  post "/login", to: "users#login"
  post "/login_2FA", to: "users#login_2FA"
  post "/top_up", to: "users#top_up"
  post "/transfer_money", to: "users#transfer_money"

  # post "/update_kyc", to: "users#update_kyc"
  # get "/transaction_history", to: "transaction_history#transaction_history"
end
