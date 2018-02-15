module Cache
  class StructHelper < Struct
    class << self
      def build_struct(hash)
        struct = new(*hash.keys.map(&:to_sym))
        struct.new(*hash.values.map)
      end
    end
  end
end