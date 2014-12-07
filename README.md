# Spider

A really bare bones web scraper used on the cli.


# Deps
make sure you have
- mongodb


installed


## Installation

Add this line to your application's Gemfile:


For Ruby projects, put this inside your gemfile
```ruby
gem 'spider'
```

For command line use, run a
```shell
gem install spider
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spider

## Usage


### Shell

Use seed when using this application for the first time.
You can use any link you want, just make sure that it's not a link that leads to a HTML page.


For example:
```shell
crawl seed http://google.com
```
This will parse the fetched html page for all its links, then store them into a mongo database instance.

This will only parse one site though.
To parse more sites, you would have to pass in a DEPTH variable after the given link.

Eg:

```shell
crawl seed http://google.com 10
```


In this example, we input a depth of 10. This means that it will parse up to 10 pages


### Ruby


```ruby
require 'spider'

Spider::Core.new
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/spider/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
