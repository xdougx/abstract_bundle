require "active_support"
require "active_support/inflector"
require "active_support/concern"
require "active_model_serializers"

require "serializable_resource"

require "abstract_bundle/version"
require "abstract_bundle/interface"
require "abstract_bundle/factory"

puts "LOL 1"
puts Dir["./lib/concerns/**.rb"]
puts "LOL 2"
puts Dir["./concerns/**.rb"]

Dir["./concerns/**.rb"].each { |f| require f }
Dir["./lib/concerns/**.rb"].each { |f| require f }

# require "concerns"


module AbstractBundle
  # standard error for methods not implementeds
  class NotImplementedError < NoMethodError
  end

  # standard error for not founded errors
  class ClassNotFound < RuntimeError
  end

end
