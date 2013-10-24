# EnvironmentCanada

An unofficial gem for retrieving weather conditions and forecasts for Canadian cities from Environment Canada. Not endorsed or affiliated with Environment Canada in any way.

## Installation

Add this line to your application's Gemfile:

    gem 'environment_canada'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install environment_canada

## Usage

### Finding a City

A list of City objects can be retrieved using the `City.find` method.

	EnvironmentCanada::City.find("Calgary")

This will return an array of `City` objects, or none if no match was found. The list of cities is bundled with the gem and includes their city codes for weather conditions and forecast lookup.

### Manually Creating a City Object

Alternatively, create a City object by passing in the city code and name:

	city = EnvironmentCanada::City.new("AB-52", "Calgary")

Case sensitivity does not matter, as the gem will automatically convert the case when connecting to the Environment Canada weather site.

### Retrieving Raw Feed XML

With a `City` object, a string with the latest XML feed can be retrieved:

	xml = city.get_feed

You can then process the XML as you see fit.

### Current Weather Conditions

TODO

### Weather Forecast

TODO

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

See LICENSE.txt.
