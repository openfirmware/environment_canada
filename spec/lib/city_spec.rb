require 'spec_helper'

describe EnvironmentCanada::City do
  it "finds a set of cities that match a term" do
    result = EnvironmentCanada::City.find("Calgary")
    result.should respond_to(:each)
  end

  it "returns the city name for a search result" do
    results = EnvironmentCanada::City.find("Calgary")
    results.first.should respond_to(:name)
  end

  it "returns the city code for a search result" do
    results = EnvironmentCanada::City.find("Calgary")
    results.first.should respond_to(:code)
  end
end
