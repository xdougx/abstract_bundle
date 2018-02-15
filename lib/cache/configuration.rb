module Cache
  # Configures global settings for ModelApi
  #   Cache.configure do |config|
  #     config.schema = {
  #       host: "127.0.0.1",
  #       port: 6379,
  #       db: 0
  #     }
  #     config.ttl = 99999
  #     config.key = 'user_id'
  #   end
  def self.configure(&_block)
    yield(config())
  end

  # Global settings for ModelApi
  def self.config
    @config ||= Cache::Configuration.new
  end

  # this configuration class has all attributes to configure
  # the api url and authorizations params
  class Configuration
    # principal attributes to execute an http request
    attr_accessor :schema, :key, :ttl

    # constructor that set default values
    def initialize
      @schema = { uri: "127.0.0.1:6379/0" }
      @ttl = 2592000
      @key = 'id'
    end
  end
end
