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
  spec.homepage      = "https://github.com/openfirmware/environment_canada"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "nokogiri"
  spec.add_dependency "safe_yaml"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
