# Module to create and validate tokens with Secure Random Hex 16
module Tokenizable
  extend ActiveSupport::Concern

  # build a Secure Random hex string
  def generate_token(attr)
    update_attribute(attr, SecureRandom.hex(16))
  end

  def validate_token(token)
    current_token?(token) ? true : self.class.raise_simple(:session_token, 'exceptions.auth.token')
  end

  def current_token?(token)
    token == session_token
  end
end
