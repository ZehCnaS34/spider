require "spider/version"
require 'spider/util'
require 'net/http'
require 'redis'
require 'json'


module Spider
  attr_reader :links
  # Your code goes here...


  def get_response(uri)
    if uri =~ /http:\/\//
       Net::HTTP.get_response(URI.parse(uri))
    else
      Net::HTTP.get_response(URI.parse("http://#{uri}"))
    end

  end


  def initialize
    @db = Redis.new(port: 6379)
    @links = Array.new
  end

  def crawl(depth=10)
    @links = JSON.parse(@db.get('links'))
    at = 0
    @links.each do |l|
      if at == depth
        break
      end
      seed(l)
      at += 1
    end
    puts @links
    puts @links.length
    @db.set "links", @links.to_json
  end


  def fetch_page(uri)
    @body = get_response(uri)
  end


  def scrape
    return nil if @body.nil

    @links.concat get_response(uri).body.split("<")
      .map(&has_dot_com).join.split(/href=['"]/)
      .map(&has_href)
      .map(&nil_or_contains_url)
      .map(&has_id)
      .compact.uniq
    puts @links.count
    self
  end
end
