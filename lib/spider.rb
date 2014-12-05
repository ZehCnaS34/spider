require "spider/version"
require 'spider/util'
require 'net/http'
require 'redis'
require 'json'


module Spider


  def initialize
    # @db = Redis.new(port: 6379)
    @links = Array.new
  end

  def crawl(depth=10)
    @links.each do |l|
      break if depth == 0
      seed(l)
      at -= 1
    end
  end

  def scrape
    return nil if @body.nil?
    @links.concat @body.split(/href=['"]/)
    puts @links
    # return self for method chaining
    self
  end

  def seed(location)
    @body = get_response(location).body
    scrape
  end
end
