# checkerberry

This is a wrapper on the GNverifier API. Code follows the spirit/approach of the Gem [colrapi](https://github.com/SpeciesFileGroup/colrapi), and indeed much of the wrapping utility is copied 1:1 from that repo.

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
Checkerberry.verify('Homo sapiens', sources: [1, 11], with_stats: true)
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

### Get version

Get API version information:
```ruby
Checkerberry.version
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SpeciesFileGroup/checkerberry.

## License

The gem is available as open source under the terms of the [MIT](https://opensource.org/licenses/MIT) license.

