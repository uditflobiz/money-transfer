class UsersController < ApplicationController
  before_action :authorized, only: [:login_2FA, :upload_kyc_docs]

  def temp
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(create_user_params)
    begin
      token = encode_token({user_id: user.id})
      user.save!
      render json: {token: token, status: 200}
    rescue ActiveRecord::RecordInvalid => e
      render json: {error: user.errors.full_messages}
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = encode_token({user_id: user.id})
      render json: {token: token, status: 200}
    else
      render json: {error: user.errors.full_messages}
    end
  end

  def otp_check(user, otp)
    return user.authenticate_otp(otp)
  end

  def login_2FA
    if otp_check(@user, params[:otp])
      render json: {status: 200}
    else
      render json: {error: 'Incorrect otp'}
    end
  end

  def upload_kyc_docs
    ActiveRecord::Base.transaction do
      params = upload_kyc_params
      @user.aadhaar_number = params[:aadhaar_number]
      @user.aadhaar_url = params[:aadhaar_url]
      @user.save!
    end
  end

  def verify_kyc
    user = User.find(params[:user_id])
    user.kyc_completed = true
    user.save!
  end
  
  private

  def create_user_params
    params.permit(:name, :email, :password, :phone_number)
  end

  def upload_kyc_params
    params.permit(:aadhaar_number, :aadhaar_url)
  end
end
