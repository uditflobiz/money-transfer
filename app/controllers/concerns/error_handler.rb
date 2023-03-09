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

    rescue_from OtpError do |e|
      render json: respond(:incorrect_otp, 404, e.to_s)
    end

    # rescue_from KycError do |e|
    #   render json: respond(:kyc_not_completed, 404, e.to_s)
    # end
  end
end

class CustomError < StandardError
end

class OtpError < StandardError
  def initialize
    super("Otp is incorrect")
  end
end

# class KycError < StandardError
#   def initialize
#     super("Kyc is not completed")
#   end
# end


def respond(error, status, message)
  {
    status: status,
    error: error,
    message: message
  }
end