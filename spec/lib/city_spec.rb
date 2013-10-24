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

  describe "conditions" do
    it "downloads the RSS feed" do
      VCR.use_cassette("calgary-feed") do
        city = EnvironmentCanada::City.new("AB-52", "Calgary")
        city.should_receive(:get_feed).and_call_original
        city.conditions
      end
    end

    it "includes the current conditions" do
      VCR.use_cassette("calgary-feed") do
        city = EnvironmentCanada::City.new("AB-52", "Calgary")
        conditions = city.conditions
        conditions[:conditions].should == "Mainly Clear"
      end
    end

    it "includes the current temperature" do
      VCR.use_cassette("calgary-feed") do
        city = EnvironmentCanada::City.new("AB-52", "Calgary")
        conditions = city.conditions
        conditions[:temperature].should == 8.5
      end
    end

    it "includes the current pressure" do
      VCR.use_cassette("calgary-feed") do
        city = EnvironmentCanada::City.new("AB-52", "Calgary")
        conditions = city.conditions
        conditions[:pressure].should == "100.3 kPa"
      end
    end

    it "includes the current pressure tendency" do
      VCR.use_cassette("calgary-feed") do
        city = EnvironmentCanada::City.new("AB-52", "Calgary")
        conditions = city.conditions
        conditions[:pressure_tendency].should == "falling"
      end
    end

    it "includes the current visibility" do
      VCR.use_cassette("calgary-feed") do
        city = EnvironmentCanada::City.new("AB-52", "Calgary")
        conditions = city.conditions
        conditions[:visibility].should == "32.2 km"
      end
    end
  end
end
