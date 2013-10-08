# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'environment_canada/version'

Gem::Specification.new do |spec|
  spec.name          = "environment_canada"
  spec.version       = EnvironmentCanada::VERSION
  spec.authors       = ["James Badger"]
  spec.email         = ["jamesbadger@gmail.com"]
  spec.description   = %q{Environment Canada weather library}
  spec.summary       = %q{Connects to Environment Canada, downloads the weather information for a city, parses it, and returns it as a Ruby object.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "safe_yaml"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
