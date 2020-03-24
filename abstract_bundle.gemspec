
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "abstract_bundle/version"

Gem::Specification.new do |spec|
  spec.name          = "abstract_bundle"
  spec.version       = AbstractBundle::VERSION
  spec.authors       = ["Douglas Rossignolli"]
  spec.email         = ["douglas.rossignolli@gmail.com"]

  spec.summary       = %q{Small lib to incluse interfaces on your ruby}
  spec.description   = %q{Abstract Bundle is a simple lib to help you to implement some interfaces (contracts) in your ruby classes}
  spec.homepage      = "https://github.com/xdougx/abstract_bundle"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", ">= 12.3.3"

  spec.add_runtime_dependency "redis"
  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "active_model_serializers"
  spec.add_runtime_dependency "bcrypt"


end
