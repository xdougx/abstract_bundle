module Cache
  class User
    # concerns
    include Cacheable

    # config
    set_cache prefix: 'user'
    delegate 'build_struct', to: Cache::StructHelper

    # attributes
    attr_accessor *%w[id email session_token phone picture_profile profile_type
                      status profile_id last_session session_expires_at recover_code
                      recover_expires_at profile address]

    def initialize(params = {})
      set_params(params)
    end

    private

    def set_params(params)
      params.each do |key, value|
        value.is_a?(Hash) ? set_attr(key, build_struct(value)) : set_attr(key, value)
      end
    end

    def set_attr(attr, value)
      send("#{attr}=", value)
    end

    class << self

      delegate 'parse', to: JSON

      def from_cache(id)
        raise_not_in_cache unless cached?(id)
        new(parse(get(id))) 
      end

    end

  end
end
