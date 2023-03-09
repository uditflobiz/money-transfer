class ApplicationController < ActionController::API
  include ErrorHandler

  def get_user_id
    auth_header = request.headers['Authorization']
    raise CustomError.new("User is not logged in") if auth_header.blank?
    token = auth_header.split(' ')[1]

    GetUserFromToken.call(token)
  end
end
