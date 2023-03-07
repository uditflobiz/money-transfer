class CreateUser < ApplicationService
  def initialize(name, email, password, phone_number)
    @name = name
    @email = email
    @password = password
    @phone_number = phone_number
  end

  def call
    user = User.new(self.as_json)
    token = encode_token({user_id: user.id})
    user.save!
    {token: token, status: 200}
  end
end