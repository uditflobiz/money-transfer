require 'sidekiq/web'
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"


Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" 

  scope 'api' do
    resources :users, only: [:create] do
      post :login, on: :collection
      post :login_2FA, on: :collection
      post :upload_kyc_docs, on: :collection
      post :verify_user_kyc, on: :collection
    end

    resources :wallets do
      post :request_otp, on: :collection
      post :top_up, on: :collection
      post :transfer_money, on: :collection
    end

    resources :transaction_histories, only: [:index]
  end

  # get "/user_transaction_history", to: "transaction_histories#get_transaction_history"

  # post "/add_currency", to: "currencies#create"
end
