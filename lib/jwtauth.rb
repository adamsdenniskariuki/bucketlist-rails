require 'jwt'

class JwtAuth

  ALGORITHM = 'HS256'

  def self.encode(payload)
    payload[:exp] = 24.hours.from_now.to_i
    JWT.encode(payload, ENV['AUTH_SECRET'], ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token, ENV['AUTH_SECRET'], true, { :algorithm => ALGORITHM }).first
  end

end
