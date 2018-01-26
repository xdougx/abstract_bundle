# Simple module to find with some attribute or raise a error
module Findable
  extend ActiveSupport::Concern

  # Simple module to find with some attribute or raise a error
  module ClassMethods
    def find_with(attr, value)
      attr = attr.to_s
      raise_simple(attr, 'exceptions.invalid_column') unless column?(attr)
      raise_model(attr,  'exceptions.not_found')      unless exists?(attr => value)
      find_by(attr => value)
    end

    def column?(attr)
      columns.map(&:name).include?(attr)
    end
  end
end
