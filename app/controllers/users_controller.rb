class UsersController < ApplicationController
  before_action :get_user, only: [:login_2FA, :upload_kyc_docs]

  def create
    render json: CreateUser.call(params[:name], params[:email], params[:password], params[:phone_number])
  end

  def login
    render json: LoginUser.call(params[:email], params[:password])
  end

  def login_2FA
    otp_status = CheckOtp.call(current_user[:id], params[:otp])
    raise AuthorizationError.new("Otp is incorrect") if !otp_status

    render json: {status: 200, message: 'Correct otp'}
  end

  def upload_kyc_docs
    params = upload_kyc_params
    current_user.aadhaar_number = params[:aadhaar_number]
    current_user.aadhaar_url = params[:aadhaar_url]
    current_user.save!
    render json: {status: 200, message: 'Kyc Docs Uploaded'}
  end

  def verify_user_kyc
    user = User.find(params[:user_id])
    user.kyc_completed = true
    user.save!
    render json: {status: 200, message: 'Kyc Verified'}
  end
  
  private
  def upload_kyc_params
    params.permit(:aadhaar_number, :aadhaar_url)
  end
end
