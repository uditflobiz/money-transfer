class UsersController < ApplicationController
  # before_action :authorized, only: [:login_2FA, :upload_kyc_docs]

  def temp
    OtpMessageJob.perform_async('bob')
  end

  def create
    render json: CreateUser.call(params[:name], params[:email], params[:password], params[:phone_number])
  end

  def login
    render json: LoginUser.call(params[:email], params[:password])
  end

  # def otp_check(user, otp)
  #   return user.authenticate_otp(otp)
  # end

  def get_user_id
    auth_header = request.headers['Authorization']
    if auth_header.blank?
      render json: CustomError.call("not_logged_in", 404, "User is not logged in") 
      return
    end
    token = auth_header.split(' ')[1]

    GetUserFromToken.call(token)
  end

  def login_2FA
    user_id = get_user_id

    otp_status = CheckOtp.call(user_id, params[:otp])

    if otp_status
      render json: {status: 200, message: 'Correct otp'}
    else
      render json: {status: 404, error: 'incorrect_otp'}
    end
  end

  def upload_kyc_docs
    user = User.find(get_user_id)
    params = upload_kyc_params
    user.aadhaar_number = params[:aadhaar_number]
    user.aadhaar_url = params[:aadhaar_url]
    user.save!
  end

  def verify_kyc
    user = User.find(params[:user_id])
    user.kyc_completed = true
    user.save!
  end
  
  private
  def upload_kyc_params
    params.permit(:aadhaar_number, :aadhaar_url)
  end
end
