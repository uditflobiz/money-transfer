module ErrorHandler  
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do |e|
      render json: respond(:standard_error, 500, e.to_s)
    end
    
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: respond(:record_not_found, 404, e.to_s)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: respond(:record_invalid, 404, e.to_s)
    end

    rescue_from JWT::DecodeError do |e|
      render json: respond(:bearer_token_invalid, 404, e.to_s)
    end
  end
end

class CustomError < StandardError
  attr_reader :status, :error, :message

  def initialize(_error=nil, _status=nil, _message=nil)
    @error = _error || 422
    @status = _status || :unprocessable_entity
    @message = _message || 'Something went wrong'
  end

  def self.call(*args)
    new(*args).fetch_json
  end

  def fetch_json
    respond(@status, @error, @message)
  end
end

def respond(_error, _status, _message)
  {
    status: _status,
    error: _error,
    message: _message
  }
end