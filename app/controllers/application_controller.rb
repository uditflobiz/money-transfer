class ApplicationController < ActionController::API
  # before_action :authorized

  include ErrorHandler
  
  def encode_token(payload)
    JWT.encode payload, 'my$ecretK3y', 'HS256'
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode token, 'my$ecretK3y', true, { algorithm: 'HS256' }
      rescue JWT::DecodeError
        raise("Wrong Token")
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
