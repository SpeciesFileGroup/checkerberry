# Checkerberry

Checkerberry is a Ruby wrapper on the [GNverifier](https://verifier.globalnames.org) API. Code follows the spirit/approach of the Gem [serrano](https://github.com/sckott/serrano), and indeed much of the wrapping utility is copied 1:1 from that repo, thanks [@sckott](https://github.com/sckott).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'checkerberry'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install checkerberry

## Usage

### Verify scientific names

Verify a single scientific name:
```ruby
Checkerberry.verify('Homo sapiens')
```

Verify multiple scientific names:
```ruby
Checkerberry.verify(['Homo sapiens', 'Mus musculus'])
```

Verify with additional options:
```ruby
Checkerberry.verify('Homo sapiens', data_sources: [1, 11], with_stats: true)
```

### Search for scientific names

Search for a species:
```ruby
Checkerberry.search(name_string: "Homo sapiens", genus: 'Homo', species: 'sapiens')
```

Search for a species within a parent taxon:
```ruby
Checkerberry.search(parent_taxon: "Plantae", genus: 'Agathis', species: 'montana')
Checkerberry.search(parent_taxon: "Animalia", genus: 'Agathis', species: 'montana')
```

Search for a species verified by specific data sources:
```ruby
Checkerberry.search(name_string: "Homo sapiens", genus: 'Homo', species: 'sapiens', data_sources: 1)
Checkerberry.search(name_string: "Homo sapiens", genus: 'Homo', species: 'sapiens', data_sources: [1, 3])
```


### Get data sources

Get list of all data sources:
```ruby
Checkerberry.data_sources
```

Get a specific data source by ID:
```ruby
Checkerberry.data_source(1)
```

### Ping service
Check if the GNverifier service is up
```ruby
Checkerberry.ping
pong
```

### Get version

Get the GNVerifier API version information:
```ruby
Checkerberry.version
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run bundle exec rake install. To release a new version, update the version number in version.rb, update the CHANGELOG.md, and then run bundle exec rake release, which will create a git tag for the version, push git commits and the created tag, and push the .gem file to rubygems.org.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SpeciesFileGroup/checkerberry. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/SpeciesFileGroup/checkerberry/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT license](https://github.com/SpeciesFileGroup/checkerberry/blob/main/LICENSE.txt). You can learn more about the MIT license on [Wikipedia](https://en.wikipedia.org/wiki/MIT_License) and compare it with other open source licenses at the [Open Source Initiative](https://opensource.org/license/mit/).

## Code of Conduct

Everyone interacting in the Checkerberry project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SpeciesFileGroup/checkerberry/blob/main/CODE_OF_CONDUCT.md).