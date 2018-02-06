module Serializable
  extend ActiveSupport::Concern

  included do
    delegate :get_serialized, to: ActiveModelSerializers::SerializableResource
  end

  def serialized
    get_serialized(self).as_json
  end

end