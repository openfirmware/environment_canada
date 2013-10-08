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
        cities.find_all do |city_code, city_name|
          city_name == keyword
        end
      end
    end

    # Instance Methods
  end
end
