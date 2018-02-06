require "active_support"
require "active_support/inflector"
require "active_support/concern"

require "abstract_bundle/version"
require "abstract_bundle/interface"
require "abstract_bundle/factory"
require "abstract_bundle/serializeble_resource"

require "concerns"


module AbstractBundle
  # standard error for methods not implementeds
  class NotImplementedError < NoMethodError
  end

  # standard error for not founded errors
  class ClassNotFound < RuntimeError
  end

end
