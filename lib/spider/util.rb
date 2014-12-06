require 'net/http'
require 'json'


module Spider
  module Util
    def when_valid_url(e)
      res = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/.match(e)

      return res.to_s.split('"')[0] if res
      nil
    end

    # append to obj var @links if not already included
    def append_to_links(l)
      @links << l if not @links.include? l
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
