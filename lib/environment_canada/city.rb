module EnvironmentCanada
  class City
    # Class Methods
    class << self
      # Return hash of cities with city codes as keys and city names as values.
      def cities
        @cities ||= YAML.load_file(File.expand_path('../../city_list_en.yml', __FILE__))['cities']
      end

      # Return list of cities that match a keyword.
      def find(keyword)
        keyword = keyword.downcase
        results = cities.find_all do |city_code, city_name|
          city_name.downcase.include?(keyword)
        end

        results.collect do |result|
          City.new(*result)
        end
      end
    end

    attr_reader :code, :name

    # Instance Methods
    def initialize(code, name)
      @code = code
      @name = name
    end

    # Return a hash with the current weather conditions
    def conditions
      feed = get_feed.body
      parse_feed(feed)
    end

    # Download the RSS conditions feed from Environment Canada
    def get_feed
      HTTParty.get(FeedBaseURL + "#{@code.downcase}_e.xml")
    end

    # Retrieve the weather conditions data from the RSS
    def parse_feed(data)
      doc = Nokogiri::XML(data)
      entries = doc.xpath('//xmlns:entry')
      current_conditions = entries.find do |entry|
        category = entry.at_xpath('xmlns:category')
        category.attribute("term").value == "Current Conditions"
      end

      conditions_basic = current_conditions.at_xpath('xmlns:title').text()
      matches = conditions_basic.match(/\ACurrent Conditions: ([^,]+), (-?\d+\.\d+)/)
      conditions = matches[1]
      temperature = matches[2].to_f

      conditions_all = current_conditions.at_xpath('xmlns:summary').text()
      matches = conditions_all.match(/<b>Pressure \/ Tendency:<\/b> (\d+.\d+ kPa) ([^<]+)/)
      pressure = matches[1]
      pressure_tendency = matches[2]

      matches = conditions_all.match(/<b>Visibility:<\/b> (\d+.\d+ km)/)
      visibility = matches[1]

      matches = conditions_all.match(/<b>Humidity:<\/b> (\d+.?\d+ %)/)
      humidity = matches[1]

      matches = conditions_all.match(/<b>Dewpoint:<\/b> (-?\d+.?\d+)/)
      dewpoint = matches[1].to_f

      matches = conditions_all.match(/<b>Wind:<\/b> (...? \d{1,3} km\/h)/)
      wind = matches[1]

      {
        conditions:        conditions,
        dewpoint:          dewpoint,
        humidity:          humidity,
        pressure:          pressure,
        pressure_tendency: pressure_tendency,
        temperature:       temperature,
        visibility:        visibility,
        wind:              wind
      }
    end
  end
end
