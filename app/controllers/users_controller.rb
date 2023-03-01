class UsersController < ApplicationController
  before_action :authorized, only: [:otp_check]

  def create
    user = User.new(user_params)
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

  def otp_check
    if @user.otp_code == params['otp']
      render json: {status: 200}
    else
      render json: {error: 'Incorrect otp'}
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :phone_number)
  end
end
