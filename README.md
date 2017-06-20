# Wallzilla

**Wallzilla** very simple ruby gem with CLI for generating mosaic images from Flickr.

It provides:

* accepts a list of search keywords as arguments
* queries the Flickr API for the top-rated (term: interestingness) image for each keyword
* downloads the results
* assembles a collage grid from ten images and
* writes the result to a user-supplied filename

## Example

    $ wz --key ~~HIDDEN~~ winter boy rocket racoon fear mars



## Installation

### Prerequisites:

This gem assumes that you have `imagemagick` installed in your system

### CLI installation:

    $ gem install wallzilla

### Programm interface

Add this line to your application's Gemfile:

```ruby
gem 'wallzilla'
```

And then execute:

    $ bundle

## CLI Usage

## Library usage

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Svenyurgensson/wallzilla.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
