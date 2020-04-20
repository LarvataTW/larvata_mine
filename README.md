[![Build
Status](https://api.travis-ci.com/FTLam11/larvata_mine.svg?branch=master)](https://travis-ci.org/FTLam11/larvata_mine)

# LarvataMine

This is an API client wrapper for Redmine. Read through the entire
README before you try anything, thanks!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'larvata_mine'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install larvata_mine

## Usage

Read the specs as always!

`LarvataMine::RestClient` has three configurable parameters: `api_key`,
`base_url`, and `timeout`. These parameters can be read from environment
variables or passed in directly to the initializer.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/FTLam11/larvata_mine. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/FTLam11/larvata_mine/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LarvataMine project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/FTLam11/larvata_mine/blob/master/CODE_OF_CONDUCT.md).
