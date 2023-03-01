class UsersController < ApplicationController
  def create
    render json: {error: "Invalid email or password"}
  end
end
