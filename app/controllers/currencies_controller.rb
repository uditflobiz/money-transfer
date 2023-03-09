class CurrenciesController < ApplicationController
  def create
    Currency.find_or_create_by(currency: params[:currency])
    render json: {status: 200, message: 'Currency added'}
  end
end