class ApplicationService
  def self.call(*args)
    new(*args).call
  end

  def encode_token(payload)
    JWT.encode payload, 'my$ecretK3y', 'HS256'
  end
end
