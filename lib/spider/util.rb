require 'net/http'
require 'json'

module Spider
  module Util

    def log(content="", &block)
      content = block.call if block_given?
      print bold, cyan, "-----Debug:[#{content}]-----", reset, "\n"
    end

    def when_valid_url(e)
      res = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/.match(e)

      return res.to_s.split('"')[0] if res
      nil
    end

    # append to obj var @links if not already included
    def append_to_links(l)
      print bold, green, "Adding: #{l}", reset, "\n"
      @links << l if not @links.include? l
    end

    def clean_link_hash(l)
      # res = /#/.match l
      # return res.to_s.split('#')[0] if res
      # nil

      l.split '#' if l =~ /#/
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

    def make_db_safe(l)
      l.encode("iso-8859-1").force_encoding("utf-8")
    end

    def corrent_encoding(e)
      Base64.decode64(e)
    end

  end
end
