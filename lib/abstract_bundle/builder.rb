module AbstractBundle
  # Base Build is a interface to Bussiness builders
  class Builder
    include AbstractBundle::Interface

    # ADDRESS_PARAMS = { address_attributes: %w(id line1 number complement city state zip district longitude latitude addressible_id addressible_type) }.freeze

    needs_implementation 'check_exists', 'create', 'update', 'commit'

  end
end