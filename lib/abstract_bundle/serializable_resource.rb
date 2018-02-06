class ActiveModelSerializers::SerializableResource
  def self.get_serialized(object)
    new(object)
  end
end