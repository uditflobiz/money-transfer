Rails.application.routes.draw do
  post "/create", to: "users#create"
  # post "/login", to: "users#login"
  # post "/update_kyc", to: "users#update_kyc"

  # post "/transfer_money", to: "transaction_history#transfer_money"
  # get "/transaction_history", to: "transaction_history#transaction_history"
end
