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
        ancestors.include?(Serializable)
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

      def raise_not_in_cache
        raise Exceptions::Simple.build(message: 'not available in cache', field: 'id')
      end

      def cached?(value)
        repository.exists?(value)
      end

    end
  end
end