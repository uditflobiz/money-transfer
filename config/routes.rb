require 'sidekiq/web'
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"


Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" 

  post "/create", to: "users#create"
  post "/login", to: "users#login"
  post "/login_2FA", to: "users#login_2FA"
  post "/update_kyc", to: "users#upload_kyc_docs"
  post "/verify_user_kyc", to: "users#verify_kyc"

  post "/top_up", to: "wallets#top_up"
  post "/transfer_money", to: "wallets#transfer_money"

  get "/user_transaction_history", to: "transaction_histories#get_transaction_history"

  post "/add_currency", to: "currencies#create"

  #test
  get "/temp", to: "users#temp"
end
