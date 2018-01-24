require "active_support"
require "active_support/inflector"

require "abstract_bundle/version"
require "abstract_bundle/interface"
require "abstract_bundle/factory"

module AbstractBundle
  # standard error for methods not implementeds
  class NotImplementedError < NoMethodError
  end

  # standard error for not founded errors
  class ClassNotFound < RuntimeError
  end

end
