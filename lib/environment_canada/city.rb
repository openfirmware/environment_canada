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

    # Download the RSS conditions feed from Environment Canada
    def get_feed
      HTTParty.get(FeedBaseURL + "#{@code.downcase}_e.xml")
    end
  end
end
