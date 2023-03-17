class GetUserFromToken < ApplicationService
  def initialize(token)
    @token = token
  end

  def call
    decoded_token = JWT.decode @token, 'my$ecretK3y', true, { algorithm: 'HS256' }
    user_id = decoded_token[0]['user_id']
    User.find_by(id: user_id)
  end
end