# Module to create and validate tokens with Secure Random Hex 16
module Tokenizable
  extend ActiveSupport::Concern

  # build a Secure Random hex string
  def generate_token(attr)
    update_attribute(attr, SecureRandom.hex(16))
  end

  def validate_token(token, attr)
    current_token?(token, attr) ? true : self.class.raise_simple(attr, 'exceptions.auth.token')
  end

  def current_token?(token, attr)
    token == send(attr)
  end
end
