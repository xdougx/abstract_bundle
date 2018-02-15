module Cache 
  # module to cache on redis
  module Cacheable
    extend ActiveSupport::Concern

    included do
      delegate 'dump', to: Marshal
    end

    def cache!
      self.class.set(self)
    rescue Redis::CannotConnectError
      false
    end

    def serialized_to_cache
      self.class.serializable? ? serialized.to_json : dump(self)
    end

    # class methods
    module ClassMethods
      attr_reader :repository
      
      def serializable?
        self.class.ancestors.include?(Serializable)
      end

      def set_cache(params = {})
        @repository = Cache::Repository.new(name.underscore, params)
      end

      def get(value)
        repository.get(value)
      end

      def set(object)
        repository.set(object)
      end

    end
  end
end