# Apstrings

Apple dot strings file parser and validator in ruby. 

Valid input strings file formats :

> ASCII
> 
> UTF8
> 
> UTF-16lE
> 
> UTF-16bE


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apstrings'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apstrings

## Usage


####1. Parse a .strings file to json/hash in ruby :
```
require 'apstrings'


	string_file = Apstring.parse('path/to/dotStringFile.strings')
	
	string_file.to_hash # => {key1 => value1 , key2 = > value2 ...} 
	
	string_file.to_json
	
	
```


####2. Run a validation for a .strings file and (optionally) compare a master .strings file to find missing keys. 

```
require 'apstrings'

Apstrings.validate('path/to/dotStringFile.strings','path/to/masterDotStringFile.strings')

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake true` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JasonWorking/apstrings. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

