# This module build up the model in to a json filtered by mobile or web version
module Jsonable
  extend ActiveSupport::Concern

  def json(device = '', options = {})
    JB.json(self, device, options)
  end
end
