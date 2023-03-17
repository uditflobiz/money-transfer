class ApplicationController < ActionController::API
  include ErrorHandler
  attr_reader :current_user
  
  def get_user
    auth_header = request.headers['Authorization']
    raise CustomError.new("User is not logged in") if auth_header.blank?
    token = auth_header.split(' ')[1]

    @current_user = GetUserFromToken.call(token)
  end
end
