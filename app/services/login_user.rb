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
      CustomError.call("record_invalid", 404, "Please check Email and Password")
    end
  end
end