# GrapeSlate

This Gem will give you methods to autogenerate Slate documentation from
your Grape API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'grape_slate', github: 'tricycle/grape_slate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape_slate

## Usage

```ruby
GrapeSlate::DocumentationGenerator.new(your_grape_api_class_goes_here).run!
```

You will also need to specify the location of your Slate `source`
directory in a config initializer file. The default location for the
generated files will be the `tmp` directory in your application root
folder.

```ruby
GrapeSlate.configure do |config|
  config.output_dir = 'api-docs/source'
  config.base_path = 'http:://www.example.com'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/grape_slate.

