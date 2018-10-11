# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'layer/version'

Gem::Specification.new do |spec|
  spec.name          = "layer-ruby"
  spec.version       = Layer::VERSION
  spec.authors       = ["Benedikt Deicke"]
  spec.email         = ["benedikt@benediktdeicke.com"]

  spec.summary       = %q{Ruby bindings for the Layer Platform API}
  spec.description   = %q{Ruby bindings for the Layer Platform API}
  spec.homepage      = "https://github.com/benedikt/layer-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", ">= 1.8", "< 3.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "yard", "~> 0.8"
end
