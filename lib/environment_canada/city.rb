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

      conditions_all = current_conditions.at_xpath('xmlns:title').text()
      matches = conditions_all.match(/\ACurrent Conditions: ([^,]+), (\d+\.\d+)/)
      conditions = matches[1]
      temperature = matches[2].to_f

      {
        conditions:  conditions,
        temperature: temperature
      }
    end
  end
end
