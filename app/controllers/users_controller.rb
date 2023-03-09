class UsersController < ApplicationController
  def temp
    OtpMessageJob.perform_async('bob')
  end

  def create
    render json: CreateUser.call(params[:name], params[:email], params[:password], params[:phone_number])
  end

  def login
    render json: LoginUser.call(params[:email], params[:password])
  end

  def login_2FA
    user_id = get_user_id
    otp_status = CheckOtp.call(user_id, params[:otp])
    raise OtpError if !otp_status

    render json: {status: 200, message: 'Correct otp'}
  end

  def upload_kyc_docs
    user = User.find(get_user_id)
    params = upload_kyc_params
    user.aadhaar_number = params[:aadhaar_number]
    user.aadhaar_url = params[:aadhaar_url]
    user.save!
    render json: {status: 200, message: 'Kyc Docs Uploaded'}
  end

  def verify_kyc
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
