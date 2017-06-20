# Wallzilla

**Wallzilla** very simple ruby gem with CLI for generating mosaic images from Flickr.

It provides:

* accepts a list of search keywords as arguments
* queries the Flickr API for the top-rated (term: interestingness) image for each keyword
* downloads the results
* assembles a collage grid from ten images and
* writes the result to a user-supplied filenameds

If given less than ten keywords, or if any keyword fails to
result in a match, gem retrieve random words from a dictionary
source such as `/usr/share/dict/words` or provided one.

I like the idea to keep library as small as I can, so it has no external dependancies (except `imagemagick`)

## Example

    $ wz --key YOUR_FLICKR_KEY winter boy rocket racoon fear mars

<img src="https://raw.github.com/svenyurgensson/wallzilla/master/images/output.jpg" alt="Example resulting mosaic"/>

## Installation

### Prerequisites:

This gem assumes that you have `imagemagick` installed in your system.

You can install it from [official site](http://www.imagemagick.org/script/download.php)

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

```shell
USAGE: wz [options] kw1 kw2 kw3 ... kw10
    -o, --output FILE                Write result to dir/to/filename.extname
    -k, --key key_string             Flickr API key string
    -w, --words [FILE]               Read words from dir/to/words file
    -t, --tile [5x2 | 4x3]           Images positioning columns x rows (4x3)
    -b, --background color           Fill background color (black)
    -v, --version                    Show version
```
### Options:

`-k, --key key_string` 
Flickr API key, you could get one [here](https://www.flickr.com/services/apps/create/apply)
You also could set environment variable `export FLICKR_KEY=YOUR_KEY` somewhere in your profile scripts or in command line:

`$ FLICKR_KEY=YOUR_KEY wz winter boy rocket racoon fear mars`

`-b, --background color` 
You could find color names [here](http://www.imagemagick.org/script/color.php)

`-w, --words [FILE]`
Just plain text file filled with words you like, line by line. Default words sources: `/usr/share/dict/words`, `/usr/share/words`.

`-t, --tile [5x2 | 4x3]`
You could choose how images will be placed in resulting mosaic `columns X rows`, default is `4x3`

## Library usage

```ruby
Wallzilla::Runner.build(kw: %w(winter boy rocket racoon fear mars),
                        result: "output.jpg", 
                        key: YOUR_FLICKR_KEY, 
                        words: nil,   # optional
                        tiles: "4x3", # optional
                        bg: "black")  # optional
```
As result you have file `output.jpg` in working directory.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Svenyurgensson/wallzilla.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
