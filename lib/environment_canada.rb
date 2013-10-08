require "httparty"
require "safe_yaml"

require "environment_canada/city"
require "environment_canada/version"

SafeYAML::OPTIONS[:default_mode] = :safe

module EnvironmentCanada
  # Your code goes here...
  FeedBaseURL = "http://www.example.com"
end
