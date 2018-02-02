# Base module to add, create and update addresses relations
module Addressible
  extend ActiveSupport::Concern

  included do
    has_one :address, as: :addressible, dependent: :destroy
    accepts_nested_attributes_for :address
  end

  def add_address(params)
    remove_address
    self.address = Address.build(params)
    save
  end

  def update_address(params)
    if address.present?
      address.build_update(params)
      save
    else
      add_address(params)
    end
  end

  def remove_address
    address.destroy if address.present?
  end

  def validate_presence_of_address
    add_error(:address, 'errors.messages.empty') if address.blank?
  end
end
