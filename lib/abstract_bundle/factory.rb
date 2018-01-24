# Small class to incluse interfaces on ruby classes
module AbstractBundle

  class Factory
    attr_reader :params, :type

    def initialize(type, params)
      @type = type
      @params = params
    end

    def self.get_builder(type, params)
      factory = new(type, params)
      factory.get_constantized_type.new(params)
    end

    def get_constantized_type
      type.camelize.constantize
    rescue
      raise_not_found
    end

    def raise_not_found
      raise AbstractBundle::ClassNotFound, "#{type} doesn't exists"
    end
  end

end