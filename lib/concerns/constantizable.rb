module Constantizable
  include ActiveSupport::Concern

  def get_constantized(type)
    self.class.get_constantized(type)
  end

  module ClassMethods
    def get_constantized(type)
      elements = constants.map {|sym| sym.to_s.underscore }
      elements.include?(type) ? get_constant(type) : raise_invalid_type
    end

    def get_constant(type)
      "#{name}::#{type.camelcase}".constantize
    end

    def raise_invalid_type
      available = constants.map { |sym_class| sym_class.to_s.underscore }.join(", ")
      raise Exceptions::Simple.build(message: "is invalid, available: #{available}", field: :type)
    end
  end

end