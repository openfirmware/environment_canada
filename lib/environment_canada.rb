require "httparty"
require "nokogiri"
require "safe_yaml"

require "environment_canada/city"
require "environment_canada/version"

SafeYAML::OPTIONS[:default_mode] = :safe

module EnvironmentCanada
  # Your code goes here...
  FeedBaseURL = "http://weather.gc.ca/rss/city/"
end
