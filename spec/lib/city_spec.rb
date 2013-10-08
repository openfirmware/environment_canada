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

  describe "get_feed" do
    it "downloads the RSS feed" do
      VCR.use_cassette("calgary-feed") do
        city = EnvironmentCanada::City.new("AB-52", "Calgary")
        xml = city.get_feed
        WebMock.should have_requested(:get, EnvironmentCanada::FeedBaseURL + "ab-52_e.xml")
      end
    end
  end
end
