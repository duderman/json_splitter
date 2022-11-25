# JsonSplitter

Splits Big JSONs into a smaller ones

## Installation

```
$ bundle install
```

## Usage

```
$ rake install
$ json_splitter
```

Or just

```
bundle exec exe/json_splitter
```

Main command

```
Usage:
  json_splitter process FILE

Options:
  -o, [--output=OUTPUT]          # Folder where to save results
  -b, [--batch-size=BATCH_SIZE]  # Batch size for generated files

Splits big jsons into smaller ones
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/duderman/json_splitter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
