# module to cache on redis
module Cacheable
  extend ActiveSupport::Concern

  def cache!
    begin
      self.class.cache(self)
    rescue Redis::CannotConnectError
      return false
    end
  end


  # class methods
  module ClassMethods
    attr_reader :redis_schema, :redis_prefix, :redis_key, :ttl

    def set_cache(params = {})
      @redis_schema = Redis.new(params[:redis_schema])
      @redis_key = params[:redis_key] ||= self.ancestors.map(&:name).include?("ActiveRecord::Base") ? "id" : nil
      @redis_prefix = params[:redis_prefix] ||= name.underscore
      @ttl = params[:ttl] ||= 300
    end

    def get(value)
      redis_schema.get(generate_key(value))
    end

    def cache(object)
      
      !!redis_schema.setex(generate_key(object.send(redis_key)), ttl, object.serialized_to_cache)
    end

    private

    def generate_key(value)
      "#{redis_prefix}-#{value}"
    end
  end
end
