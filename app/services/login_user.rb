class LoginUser < ApplicationService
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    user = User.find_by(email: @email)
    if user && user.authenticate(@password)
      token = encode_token({user_id: user.id})
      {token: token, status: 200}
    else
      raise CustomError.new("Please check Email and Password")
    end
  end
end