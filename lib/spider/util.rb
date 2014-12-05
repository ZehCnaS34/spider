require 'net/http'
require 'json'

module Spider
  module Util
    def nil_or_contains_url(e)
      puts "fuck"
      puts e
      e if  e =~ /http:\/\/.+(.com|.net|.org|edu)/
    end

    def has_dot_com(i)
      i.split(/['"]/)[0]
    end

    def has_href(i)
      i if i =~ /href=/
    end

    def has_quote(i)
      i.split(/['"]/)[0]
    end

    def has_id(i)
    end

    def get_response(uri)
      if uri =~ /http:\/\//
        Net::HTTP.get_response(URI.parse(uri))
      else
        Net::HTTP.get_response(URI.parse("http://#{uri}"))
      end

    end

    def fetch_page(uri)
      @body = get_response(uri)
    end


  end
end
