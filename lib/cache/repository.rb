module Cache
  class Repository
    delegate 'config', to: Cache
    delegate 'dump', to: Marshal

    attr_reader :repo, :prefix, :key, :ttl

    def initialize(prefix, params)
      @repo  = Redis.new(config.scheema.merge!(params[:schema]))
      @prefix = params.key?(:prefix) ? params[:prefix] : prefix
      @key    = params.key?(:key)    ? params[:key]    : config.key
      @ttl    = params.key?(:ttl)    ? params[:ttl]    : config.ttl
    end

    def get(value)
      repo.get(generate_key(value))
    end

    def set(object)
      !!repo.setex(generate_key(object.send(key)), ttl, object.serialized_to_cache)
    end

    private

    def config
      Cache.config
    end

    def generate_key(value)
      "#{prefix}-#{value}"
    end

  end
end