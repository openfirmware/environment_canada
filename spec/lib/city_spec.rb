require 'spec_helper'

describe EnvironmentCanada::City do
  it "finds a set of cities that match a term" do
    pending
    result = EnvironmentCanada::City.find("Calgary")
    result.should respond_to(:each)
  end
end
